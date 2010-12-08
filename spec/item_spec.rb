require './src/item'

describe "Item" do
	it "should be able to calculate the lead time" do
		item = Item.new 1
		item.complete 4
		item.leadTime.should be 3
	end
end
