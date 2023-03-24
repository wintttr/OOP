require "check_correctness_writer.rb"

class DataList
	extend CheckCorrectnessWriter
	
	attr_accessor :stored_class
	attr_reader :array
	
	def self.elements_equal? array
		array.each_cons(2).all? { |obj| obj[0] == obj[1] }
	end 
	
	def self.elements_equal_to? array, el
		array.all? { |obj| obj == el }
	end
	
	def check_array arr
		classes_equal = self.class.elements_equal?(arr.map{|obj| obj.class})
		classes_equal_stored = self.class.elements_equal_to?(arr.map{|obj| obj.class}, self.stored_class)
		
		not arr.nil? and not arr.empty? and classes_equal and classes_equal_stored
	end
	
	def array= value
		if self.check_array value then
			@array = value.zip(Array.new value.size, false)
		else
			raise ArgumentError, "Wrong array class"
		end
	end
	
	private :check_array
	protected :array, :"array="
	protected :stored_class, :"stored_class="
	
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def initialize arr
		self.stored_class = arr.first.class
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
	
	def get_names
		["№"] | self.get_names_impl
	end
	
	def get_data
		arr = Array.new
		
		self.get_data_impl.each_with_index do |obj, index|
			arr.append ([index] + obj)
		end
		
		DataTable.new arr
	end
end