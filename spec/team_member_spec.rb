require './src/team_member'

describe "TeamMember" do
 	before(:each) do
		@completed_work_queue = ItemQueue.new
		@available_work_queue = ItemQueue.new
 	end

 	it "should be able to do work" do
		team_member = TeamMember.new @completed_work_queue 
  	team_member.update 1
		@completed_work_queue.length.should be 1
 	end

	it "should be able to do available work if feeding from a queue" do
		@available_work_queue.enq Item.new(1)
		
		team_member = TeamMember.new @completed_work_queue, 1, @available_work_queue
		team_member.update 1
		@completed_work_queue.length.should be 1
	end

	it "should not be able to do work if no work is available from the feeding queue" do 
		team_member = TeamMember.new @completed_work_queue, 1, @available_work_queue
		team_member.update 1
		@completed_work_queue.length.should be 0
	end

	it "should not be able to do more work that is availabe from he feeding queue" do 
		@available_work_queue.enq Item.new(1)
		@available_work_queue.enq Item.new(1)
		
		team_member = TeamMember.new @completed_work_queue, 3, @available_work_queue
		team_member.update 1
		@completed_work_queue.length.should be 2
	end
	
	it "should remove work from the available work queue once and item of work has been completed" do 
		@available_work_queue.enq Item.new(1)
		
		team_member = TeamMember.new @completed_work_queue, 1, @available_work_queue
		team_member.update 1
		@available_work_queue.length.should be 0
	end

	it "should create work items with the correct start time" do
		team_member = TeamMember.new @completed_work_queue 
		team_member.update 2
		@completed_work_queue.deq.started_at.should be 2
	end

	it "should update the completed time when a work on it has been completed" do
		@available_work_queue.enq Item.new(1)
		
		team_member = TeamMember.new @completed_work_queue, 1, @available_work_queue
		team_member.update 2
		@completed_work_queue.deq.completed_at.should be 2
	end
end
