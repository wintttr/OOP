require_relative "student"
require_relative "exceptions"
require_relative "data_list_student_short"
require_relative "basic_students_file"


class StudentsListTXT < BasicStudentsFile
	def read_all_objects file
		array = []
		File.foreach(file) do |line|
			array.append(str_to_obj line)
		end
		obj_array = array
	end
	
	def write_all_objects file
		File.open(file) do |f|
			obj_array.each do |obj|
				f.puts(obj_to_str obj)
			end
		end
	end
end