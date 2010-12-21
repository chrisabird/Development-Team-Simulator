require 'queue'

describe "Queue" do
  before(:each) do
    @queue = ItemQueue.new
  end

	it "should be able to enqueue items of work" do
		@queue.enq Item.new(1)
		@queue.length.should be 1
	end

	it "should be able to dequeue items of work" do
		@queue.enq Item.new(1)
		@queue.enq Item.new(2)
		@queue.deq.defined_at.should be 1
	end

	it "should be able to tell if there are items of work available" do
		@queue.enq Item.new(1)
		@queue.has_available_items.should be true
	end

	it "should be able to tell if there are no items of work available" do
		@queue.has_available_items.should be false
	end
end
