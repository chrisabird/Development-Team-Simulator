class Batch
  attr_reader :completed_work, :items_to_work_on
  def initialize
    @number_of_items_to_work_on = 0
    @items_to_work_on = []
    @completed_work = []
  end
	
	def has_available_items
	 @items_to_work_on.length > 0
	end

  def deq
    @items_to_work_on.shift
  end

  def enq(item)
    @completed_work << item
  end

  def length
    @items_to_work_on.length
  end

  def is_not_complete 
    @completed_work.length != @number_of_items_to_work_on
  end

  def add_item_to_work_on(item)
    @items_to_work_on << item
    @number_of_items_to_work_on = @number_of_items_to_work_on.next
  end
end
