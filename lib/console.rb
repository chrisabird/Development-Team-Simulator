require 'team_member'
require 'queue'
require 'item'
require 'calendar'

analyst_queue = ItemQueue.new
developer_queue = ItemQueue.new
qa_queue = ItemQueue.new
done_queue = ItemQueue.new
		
for i in 1..10 do
	item = Item.new 1
	item.add_unit_of_work_for :analyst, UnitOfWork.new(1)
	item.add_unit_of_work_for :developer, UnitOfWork.new(2)
	item.add_unit_of_work_for :qa, UnitOfWork.new(2)
	analyst_queue.enq item
end

analyst = TeamMember.new developer_queue, analyst_queue
analyst.add_role :analyst
developer = TeamMember.new qa_queue, developer_queue
developer.add_role :developer
qa = TeamMember.new done_queue, qa_queue
qa.add_role :qa
		
calendar = Calendar.new
qa.listen_to calendar
developer.listen_to calendar
analyst.listen_to calendar

puts "Work in progress..."
puts "analyst   developer qa        done"
for i in 1..20 do
	calendar.move_to_next_day
  print analyst_queue.length.to_s.ljust(10)
  print developer_queue.length.to_s.ljust(10)
  print qa_queue.length.to_s.ljust(10)
  puts done_queue.length.to_s
end

puts ""
puts "Lead times..."
puts "defined   completed lead time  variance"
numberOfCompletedItems = done_queue.length
averageLeadTime = 0
for i in 1..numberOfCompletedItems do
	item = done_queue.deq
	averageLeadTime = averageLeadTime + item.leadTime
	print item.defined_at.to_s.ljust(10)
	print item.completed_at.to_s.ljust(10)
	print item.leadTime.to_s.ljust(10)
	puts item.variance
end
averageLeadTime = averageLeadTime / numberOfCompletedItems
puts "Average lead time " + averageLeadTime.to_s
