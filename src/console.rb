require './team_member'
require './queue'
require './item'
require './calendar'

@analyst_queue = ItemQueue.new
@developer_queue = ItemQueue.new
@qa_queue = ItemQueue.new
@done_queue = ItemQueue.new
		
@customer = TeamMember.new @analyst_queue, 20
@analyst = TeamMember.new @developer_queue, 1, @analyst_queue
@developer = TeamMember.new @qa_queue, 5, @developer_queue
@qa = TeamMember.new @done_queue, 2, @qa_queue
		
@calendar = Calendar.new
@qa.listen_to @calendar
@developer.listen_to @calendar
@analyst.listen_to @calendar
@customer.listen_to @calendar

for i in 1..10 do
	@calendar.move_to_next_day
  print @analyst_queue.length.to_s.ljust(10)
  print @developer_queue.length.to_s.ljust(10)
  print @qa_queue.length.to_s.ljust(10)
  puts @done_queue.length.to_s
end

averageLeadTime = 0
for item in @done_queue do
	averageLeadTime = averageLeadTime + item.leadTime
	print item.started_at.to_s.ljust(5)
	print item.completed_at.to_s.ljust(5)
	puts item.leadTime
end
averageLeadTime = averageLeadTime / @done_queue.length
puts averageLeadTime
