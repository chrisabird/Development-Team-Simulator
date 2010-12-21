require 'unit_of_work'

describe "Unit of Work" do
	before(:each) do 
		variance_mock = mock('variance')
		variance_mock.stub(:calculate).and_return {|estimate| estimate}
		Variance.stub!(:new).and_return(variance_mock)
  end

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

	it "should be able to calculate variance" do
		unit_of_work = UnitOfWork.new(1)
		unit_of_work.work_on 1
		unit_of_work.variance.should be 0
	end
end	
