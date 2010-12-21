require 'team_member'

describe "TeamMember" do
	before(:each) do 
		variance_mock = mock('variance')
		variance_mock.stub(:calculate).and_return {|estimate| estimate}
		Variance.stub!(:new).and_return(variance_mock)
		@completed_work_queue = ItemQueue.new
		@available_work_queue = ItemQueue.new
 	end

	it "should not be able to do work if no work is available from the feeding queue" do 
		team_member = TeamMember.new @completed_work_queue, @available_work_queue
		team_member.update 1
		@completed_work_queue.length.should be 0
	end
	
	it "should remove work from the available work queue once and item of work has been started" do 
		item_of_work = Item.new(1)
		item_of_work.add_unit_of_work_for :developer, UnitOfWork.new(1)
		@available_work_queue.enq item_of_work
		
		team_member = TeamMember.new @completed_work_queue, @available_work_queue
		team_member.update 1
		@available_work_queue.length.should be 0
	end
	
	it "should update the completed time when a work on it has been completed" do
		item_of_work = Item.new(1)
		item_of_work.add_unit_of_work_for :developer, UnitOfWork.new(2)
		@available_work_queue.enq item_of_work
		
		team_member = TeamMember.new @completed_work_queue, @available_work_queue
		team_member.add_role :developer
		team_member.update 1
		team_member.update 2
		@completed_work_queue.deq.completed_at.should be 2
	end

	it "should only do work for the role a team member has been allocated" do 
		item_of_work = Item.new(1)
		item_of_work.add_unit_of_work_for :developer, UnitOfWork.new(1)
		item_of_work.add_unit_of_work_for :tester, UnitOfWork.new(1)
		@available_work_queue.enq item_of_work
		
		team_member = TeamMember.new @completed_work_queue, @available_work_queue
		team_member.add_role :developer
		team_member.update 1
		
		@completed_work_queue.length.should be 1 
	end

	it "should do work for all the roles that a team member has been allocated" do 
		item_of_work = Item.new(1)
		item_of_work.add_unit_of_work_for :developer, UnitOfWork.new(1)
		item_of_work.add_unit_of_work_for :tester, UnitOfWork.new(1)
		@available_work_queue.enq item_of_work
		
		team_member = TeamMember.new @completed_work_queue, @available_work_queue
		team_member.add_role :developer
		team_member.add_role :tester
		team_member.update 1
		team_member.update 2
		
		@completed_work_queue.length.should be 1
		@completed_work_queue.deq.completed_at.should be 2
	end
end
