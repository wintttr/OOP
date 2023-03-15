require_relative "check_correctness_writer"

class DataTable
	extend CheckCorrectnessWriter

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
	def self.check_array arr
		arr.size > 0 and
		arr.each_cons(2){ |sub_arr| sub_arr[0].size == sub_arr[1].size }
	end
	
	attr_reader :array
	checked_writer :array, self.method(:check_array), nil_expected: false
end