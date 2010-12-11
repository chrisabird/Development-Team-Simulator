require 'calendar'

describe "Calendar" do
	before(:each) do
		@calendar = Calendar.new
	end

	it "should be able to move to the next day" do
		@calendar.move_to_next_day
		@calendar.day.should be 1
	end
end
