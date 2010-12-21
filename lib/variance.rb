class Variance
	def calculate (estimate)
		min = (estimate - estimate * 2) + 1
		max = estimate
		random_variance = Random.new.rand(min..max)
		estimate + random_variance	
	end
end
