require 'team_member'
require 'queue'
require 'item'
require 'calendar'
require 'batch'

describe "Team" do

  it "should be able to act like a simple team" do

    @analyst_queue = ItemQueue.new
		@developer_queue = ItemQueue.new
    @qa_queue = ItemQueue.new
    @done_queue = ItemQueue.new

		@analyst_queue.enq Item.new 1
		
    @analyst = TeamMember.new @developer_queue, 1, @analyst_queue
    @developer = TeamMember.new @qa_queue, 1, @developer_queue
    @qa = TeamMember.new @done_queue, 1, @qa_queue
		
		@calendar = Calendar.new
		@qa.listen_to @calendar
		@developer.listen_to @calendar
		@analyst.listen_to @calendar
				
		@calendar.move_to_next_day
    @analyst_queue.length.should be 0
    @developer_queue.length.should be 1
    @qa_queue.length.should be 0
    @done_queue.length.should be 0

		@calendar.move_to_next_day
    @analyst_queue.length.should be 0
    @developer_queue.length.should be 0
    @qa_queue.length.should be 1
    @done_queue.length.should be 0

		@calendar.move_to_next_day
    @analyst_queue.length.should be 0
    @developer_queue.length.should be 0
    @qa_queue.length.should be 0
    @done_queue.length.should be 1

		item = @done_queue.deq
		item.started_at.should be 1
		item.completed_at.should be 3
		item.leadTime.should be 3
  end

	it "should be able to act like an iterative team" do
		batches = [Batch.new, Batch.new]
		batches[0].add_item_to_work_on Item.new 1
		batches[1].add_item_to_work_on Item.new 1
		
		calendar = Calendar.new

		for batch_number in 0..1 do
			batch = batches[batch_number]

			developer_queue = ItemQueue.new
    	qa_queue = ItemQueue.new
		
    	analyst = TeamMember.new developer_queue, 1, batch
    	developer = TeamMember.new qa_queue, 1, developer_queue
    	qa = TeamMember.new batch, 1, qa_queue
		
			qa.listen_to calendar
			developer.listen_to calendar
			analyst.listen_to calendar

			while batch.is_not_complete do
				calendar.move_to_next_day
			end
		end

		batches[0].completed_work[0].leadTime.should be 3
		batches[1].completed_work[0].leadTime.should be 6
  end

end
