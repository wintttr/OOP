require "check_correctness_writer.rb"
require "data_table.rb"

class DataList
	extend CheckCorrectnessWriter
	
	# Геттеры/сеттеры
	attr_accessor :stored_class
	attr_reader :array
	checked_writer :array, :check_array, nil_expected: false, preprocess: lambda {|arr| arr.zip(Array.new arr.size, false)}

	public :"array="
	protected :stored_class, :"stored_class="
	private :array
	
	# Публичные методы
	
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
	
	# Защищённые методы
	
	protected
	
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def self.elements_equal_to? array, el
		array.all? { |obj| obj == el }
	end
	
	def check_array arr
		classes_equal_stored = DataList.elements_equal_to?(arr.map{|obj| obj.class}, self.stored_class)
		
		not arr.empty? and classes_equal_stored
	end
end