require 'unit_of_work'

describe "Unit of Work" do
	it "should be able to be worked on" do 
		unit_of_work = UnitOfWork.new(1)
		unit_of_work.is_completed.should be false
		unit_of_work.work_on 1
		unit_of_work.is_completed.should be true
	end


	it "should be able tell when it was completed" do
		unit_of_work = UnitOfWork.new(1)
		unit_of_work.is_completed.should be false
		unit_of_work.work_on 1
		unit_of_work.completed_at.should be 1
	end
end	
