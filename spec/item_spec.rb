require 'item'

describe "Item" do
	it "should be able to calculate the lead time" do
		item = Item.new 1
		item.add_unit_of_work_for :developer, UnitOfWork.new(3)

		item.do_work_for [:developer], 3
		item.do_work_for [:developer], 4
		item.do_work_for [:developer], 5
		
		item.leadTime.should be 5
	end

	it "should be able to tell if all work has been completed for a role" do
		item = Item.new 1
		item.add_unit_of_work_for :developer, UnitOfWork.new(1)
		item.add_unit_of_work_for :tester, UnitOfWork.new(1)

		item.do_work_for [:developer], 1
		item.do_work_for [:developer], 2

		item.all_work_completed_for([:developer]).should be true
	end

	it "should be able to tell if all work has not been completed for a role" do
		item = Item.new 1
		item.add_unit_of_work_for :developer, UnitOfWork.new(1)
		item.add_unit_of_work_for :tester, UnitOfWork.new(1)

		item.do_work_for [:developer], 1
		item.do_work_for [:developer], 2

		item.all_work_completed_for([:tester]).should be false
	end

	it "should be able to tell if all work has been completed for many roles" do
		item = Item.new 1
		item.add_unit_of_work_for :developer, UnitOfWork.new(1)
		item.add_unit_of_work_for :tester, UnitOfWork.new(1)
		item.add_unit_of_work_for :analyst, UnitOfWork.new(1)

		item.do_work_for [:developer, :tester], 1
		item.do_work_for [:developer, :tester], 2
		item.do_work_for [:developer, :tester], 3
		
		item.all_work_completed_for([:developer, :tester]).should be true
	end
end
