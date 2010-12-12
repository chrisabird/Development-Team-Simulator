require 'team_member'
require 'queue'
require 'item'
require 'calendar'
require 'batch'

describe "Team" do

  it "should be able to act like a simple push team" do

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

  it "should be able to work like a water fall team" do
    analyst_batch = Batch.new
		developer_batch = Batch.new
		qa_batch = Batch.new
		
   	item_one = Item.new 1
		item_two = Item.new 1

		developer_batch.add_item_to_work_on item_one
		developer_batch.add_item_to_work_on item_two
		analyst_batch.add_item_to_work_on item_one
		analyst_batch.add_item_to_work_on item_two
		qa_batch.add_item_to_work_on item_one
		qa_batch.add_item_to_work_on item_two

    calendar = Calendar.new

    analyst = TeamMember.new analyst_batch, 1, analyst_batch
		analyst.listen_to calendar
    while analyst_batch.is_not_complete do
    	calendar.move_to_next_day
    end

    developer = TeamMember.new developer_batch, 1, developer_batch
		developer.listen_to calendar
    while developer_batch.is_not_complete do
    	calendar.move_to_next_day
    end

		qa = TeamMember.new qa_batch, 1, qa_batch
    qa.listen_to calendar
		while qa_batch.is_not_complete do
    	calendar.move_to_next_day
    end

    qa_batch.completed_work[0].leadTime.should be 5
    qa_batch.completed_work[1].leadTime.should be 6
  end
end
