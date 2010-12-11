require 'team_member'
require 'queue'
require 'item'
require 'calendar'

@analyst_queue = ItemQueue.new
@developer_queue = ItemQueue.new
@qa_queue = ItemQueue.new
@done_queue = ItemQueue.new
		
@customer = TeamMember.new @analyst_queue, 5
@analyst = TeamMember.new @developer_queue, 1, @analyst_queue
@developer = TeamMember.new @qa_queue, 5, @developer_queue
@qa = TeamMember.new @done_queue, 2, @qa_queue
		
@calendar = Calendar.new
@qa.listen_to @calendar
@developer.listen_to @calendar
@analyst.listen_to @calendar
@customer.listen_to @calendar

puts "Work in progress..."
puts "analyst   developer qa        done"
for i in 1..20 do
	@calendar.move_to_next_day
  print @analyst_queue.length.to_s.ljust(10)
  print @developer_queue.length.to_s.ljust(10)
  print @qa_queue.length.to_s.ljust(10)
  puts @done_queue.length.to_s
end

puts ""
puts "Lead times..."
puts "started   completed lead time"
numberOfCompletedItems = @done_queue.length
averageLeadTime = 0
for i in 1..numberOfCompletedItems do
	item = @done_queue.deq
	averageLeadTime = averageLeadTime + item.leadTime
	print item.started_at.to_s.ljust(10)
	print item.completed_at.to_s.ljust(10)
	puts item.leadTime
end
averageLeadTime = averageLeadTime / numberOfCompletedItems
puts "Average lead time " + averageLeadTime.to_s
