class ItemQueue
	def initialize 
		@queue = []
	end
	
	def has_available_items
		@queue.length > 0
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
end
