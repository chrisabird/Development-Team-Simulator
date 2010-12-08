require './team_with_no_batching'
require './team_member'
require './queue'

@customer = TeamMember.new
@analyst_queue = Queue.new
@analyst = TeamMember.new
@developer_queue = Queue.new
@developer = TeamMember.new
@qa_queue = Queue.new
@qa = TeamMember.new
@done_queue = Queue.new
@team = TeamWithNoBatching.new(@customer, @analyst_queue, @analyst, @developer_queue, @developer, @qa_queue, @qa, @done_queue)

@customer.set_number_of_items_able_to_complete 20
@analyst.set_number_of_items_able_to_complete 10
@developer.set_number_of_items_able_to_complete 5
@qa.set_number_of_items_able_to_complete 2


for i in 1..20 do
  @team.do_work
  print @analyst_queue.item_count.to_s.ljust(5)
  print @developer_queue.item_count.to_s.ljust(5)
  print @qa_queue.item_count.to_s.ljust(5)
  puts @done_queue.item_count.to_s
end
