require_relative "data_list"
require_relative "data_table"
require_relative "student_short"

class DataListStudentShort < DataList
	public_class_method :new
	
	private
	def self.get_names_impl
		StudentShort.all_fields - ["id"]
	end
	
	def get_data_impl
		array.map do |student|
			student.filter{|field, value| field != :id}.map{|field, value| value}
		end
	end
end