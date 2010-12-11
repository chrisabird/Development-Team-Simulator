require 'team_member'
require 'queue'
require 'item'
require 'calendar'

describe "Team" do
  before(:each) do
    @analyst_queue = ItemQueue.new
		@developer_queue = ItemQueue.new
    @qa_queue = ItemQueue.new
    @done_queue = ItemQueue.new
		
		@customer = TeamMember.new @analyst_queue
    @analyst = TeamMember.new @developer_queue, 1, @analyst_queue
    @developer = TeamMember.new @qa_queue, 1, @developer_queue
    @qa = TeamMember.new @done_queue, 1, @qa_queue
		
		@calendar = Calendar.new
		@qa.listen_to @calendar
		@developer.listen_to @calendar
		@analyst.listen_to @calendar
		@customer.listen_to @calendar
	end

  it "should be able to create and analyse work" do
		@calendar.move_to_next_day
    @analyst_queue.length.should be 1
    @developer_queue.length.should be 0
    @qa_queue.length.should be 0
    @done_queue.length.should be 0
				
		@calendar.move_to_next_day
    @analyst_queue.length.should be 1
    @analyst_queue.length.should be 1
    @developer_queue.length.should be 1
    @qa_queue.length.should be 0
    @done_queue.length.should be 0

		@calendar.move_to_next_day
    @analyst_queue.length.should be 1
    @developer_queue.length.should be 1
    @qa_queue.length.should be 1
    @done_queue.length.should be 0

		@calendar.move_to_next_day
    @analyst_queue.length.should be 1
    @developer_queue.length.should be 1
    @qa_queue.length.should be 1
    @done_queue.length.should be 1

		@done_queue.deq.leadTime.should be 3
  end
end
    
