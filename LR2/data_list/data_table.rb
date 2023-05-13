require "check_correctness_writer.rb"

class DataTable
	extend CheckCorrectnessWriter
	
	# Геттеры и сеттеры
	attr_reader :array
	checked_writer :array, :check_array, nil_expected: false

	def initialize(arr)
		self.array = Array.new(arr)
	end
	
	def get(x, y)
		self.array[x][y]
	end

	def rows
		self.array.size
	end
	
	def cols
		if(self.rows > 0)
			self.array[0].size
		else
			nil
		end 
	end
	
	private
	def self.check_subarrays_size_equality(arr)
		arr.each_cons(2).all? do |sub_arr|
		sub_arr[0].size == sub_arr[1].size
		end
	end
	
	def self.check_array(arr)
		arr.size > 0 and self.check_subarrays_size_equality(arr)
	end
end