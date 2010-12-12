require 'batch'

describe "Batch" do
  before(:each) do
    @batch = Batch.new
  end

  it "should be able to calculate the number of items that can be worked on when there is enough" do
    @batch.add_item_to_work_on Item.new(1)
    @batch.add_item_to_work_on Item.new(1)
    number_of_items_that_can_be_worked_on = @batch.how_many_items_can_be_work_on 2
    number_of_items_that_can_be_worked_on.should be 2
  end

  it "should be able to calculate the number of items that can be worked on when there is not enough" do
    @batch.add_item_to_work_on Item.new(1)
    @batch.add_item_to_work_on Item.new(1)
    number_of_items_that_can_be_worked_on = @batch.how_many_items_can_be_work_on 4
    number_of_items_that_can_be_worked_on.should be 2
  end

  it "should be able to calculate the number of items that can b worked on when the queue is empty" do
    number_of_items_that_can_be_worked_on = @batch.how_many_items_can_be_work_on 2
    number_of_items_that_can_be_worked_on.should be 0
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
end
