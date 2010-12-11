class ItemQueue
	def initialize 
		@queue = []
	end

  def how_many_items_can_be_work_on (number_of_items_able_to_complete)
    number_of_items_completed = 0
    if has_pending_work
      if has_enough_to_work_on_for number_of_items_able_to_complete
        number_of_items_completed = number_of_items_able_to_complete
      else
        number_of_items_completed = length
      end
    end
    return number_of_items_completed
  end

	def deq
		@queue.shift
	end

	def enq(item)
		@queue << item
	end

	def length
		@queue.length
	end

  private 
  def has_enough_to_work_on_for (number_of_items_able_to_complete)
    length >= number_of_items_able_to_complete
  end

  def has_pending_work
    length > 0
  end
end
