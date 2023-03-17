require_relative "check_correctness_writer"

class DataList
	extend CheckCorrectnessWriter
	
	attr_reader :array
	checked_writer :array, lambda {|arr| arr.size > 0}, nil_expected: false, preprocess: lambda{|arr| arr.zip(Array.new arr.size, false)}
	
	protected :array, :"array="
	
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def initialize arr
		self.array = arr
	end
	
	def select num
		self.array[num][1] = true
	end
	
	# Наверное, такой метод должен быть
	def unselect
		self.array.each {|x| x[1] = false}
	end
	
	def get_selected
		self.array
			.filter {|x| x[1] == true}
			.map {|x| x[0].id}
	end
	
	def self.get_names
		["№"] | self.get_names_impl
	end
	
	def get_data
		arr = Array.new
		
		get_data_impl.each_with_index do |obj, index|
			arr.append ([index] + obj)
		end
		
		DataTable.new arr
	end
end