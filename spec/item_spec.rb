require 'item'

describe "Item" do
	it "should be able to calculate the lead time" do
		item = Item.new 2
		item.complete 5
		item.leadTime.should be 4
	end
end
