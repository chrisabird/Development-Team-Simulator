require 'batch'

describe "Batch" do
  before(:each) do
    @batch = Batch.new
  end
  
	it "should be able to enqueue completed items work" do
    @batch.enq Item.new(1)
    @batch.completed_work.length.should be 1
  end

  it "should be able to dequeue items available to work on" do
    @batch.add_item_to_work_on Item.new(1)
    @batch.add_item_to_work_on Item.new(2)
    @batch.items_to_work_on.length.should be 2
  end

  it "should be able to tell when all work has been completed in a batch" do
    @batch.add_item_to_work_on Item.new(1)
    @batch.is_not_complete.should be true
    item_in_progress = @batch.deq
    @batch.is_not_complete.should be true
    @batch.enq item_in_progress
    @batch.is_not_complete.should be false
  end
	
	it "should be able to tell if there are items of work available" do
		@batch.add_item_to_work_on Item.new(1)
		@batch.has_available_items.should be true
	end

	it "should be able to tell if there are no items of work available" do
		@batch.has_available_items.should be false
	end
end
