require 'item'

describe "Item" do
	it "should be able to calculate the lead time" do
		item = Item.new 2
		item.complete 5
		item.leadTime.should be 4
	end

	it "should be able to give you the duration of time needed to complete a roles work on the item" do
		item = Item.new 1
		item.add_estimate_for_role :developer, 10
		item.get_duration_for(:developer).should be 10
	end

	it "should give a duration of work of zero when asking for a duration for a role that has no estimate" do 
		item = Item.new 1
		item.get_duration_for(:developer).should be 0
	end
end
