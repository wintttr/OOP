class DataList
	attr_accessor :array
	
	def initialize arr
		self.array = arr.zip(Array.new arr.size, false)
	end
	
	def select num
		self.array[num][1] = true
	end
	
	def get_selected
		self.array
			.filter {|x| x[1] == true}
			.map {|x| x[0].id}
	end
	
	def get_names
		# not implemented yet
	end
	
	def get_data
		# not implemented yet
	end
end