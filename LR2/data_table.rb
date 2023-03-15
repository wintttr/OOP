class DataTable
	def initialize arr
		self.array = Array.new arr
	end
	
	def get x, y
		self.array[x][y]
	end

	def rows
		self.array.size
	end
	
	def cols
		self.array[0].size
	end
	
	private
	attr_accessor :array
end