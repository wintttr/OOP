require_relative "data_list"
require_relative "data_table"
require_relative "student_short"

class DataListStudentShort < DataList
	def self.get_names
		["№"] | (StudentShort.all_fields - ["id"])
	end
	
	def get_data
		arr = Array.new
		
		array.each_with_index do |student, index|
			[index] | student.filter{|field, value| field != :id}.map{|field, value| value}
		end
		
		DataTable.new arr
	end
end