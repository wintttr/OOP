require "data_list.rb"
require "data_table.rb"
require "student_short.rb"

class DataListStudentShort < DataList
	public_class_method :new
	
	private
	def self.stored_class
		StudentShort.class
	end
	
	def self.get_names_impl
		StudentShort.all_fields - ["id"]
	end
	
	def get_data_impl
		array.map do |student|
			student.filter{|field, value| field != :id}.map{|field, value| value}
		end
	end
end