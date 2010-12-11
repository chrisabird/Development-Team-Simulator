require 'queue'

describe "Queue" do
  before(:each) do
    @queue = ItemQueue.new
  end

  it "should be able to calculate the number of items that can be worked on when there is enough" do
    @queue.enq Item.new(1)
    @queue.enq Item.new(1)
    number_of_items_that_can_be_worked_on = @queue.how_many_items_can_be_work_on 2
    number_of_items_that_can_be_worked_on.should be 2
  end

  it "should be able to calculate the number of items that can be worked on when there is not enough" do
    @queue.enq Item.new(1)
    @queue.enq Item.new(1)
    number_of_items_that_can_be_worked_on = @queue.how_many_items_can_be_work_on 4
    number_of_items_that_can_be_worked_on.should be 2
  end

  it "should be able to calculate the number of items that can b worked on when the queue is empty" do
    number_of_items_that_can_be_worked_on = @queue.how_many_items_can_be_work_on 2
    number_of_items_that_can_be_worked_on.should be 0
  end
end
