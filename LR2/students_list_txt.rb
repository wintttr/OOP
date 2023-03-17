require_relative "student"
require_relative "exceptions"
require_relative "data_list_student_short"


class StudentsListTXT
	attr_accessor :obj_array
	
	def initialize
		self.obj_array = []
	end
	
	def read_all_objects file
		File.foreach(file) do |line|
			obj_array.append(read_obj line)
		end
	end
	
	def write_all_objects file
		File.open(file, "w") do |f|
			obj_array.each do |obj|
				f.puts(write_obj obj)
			end
		end
	end
	
	def add_obj obj
		obj_array.append obj
	end
	
	def get_index id
		index = obj_array.find_index {|item| item.id == id}
		
		if index == nil then raise ObjectNotFound, id end
		
		index
	end
	
	def get_obj id
		index = get_index id
		obj_array[index]
	end
	
	
	def upd_obj id, obj
		index = get_index id
		obj_array[index] = obj
	end
	
	def del_obj id
		index = get_index id
		obj_array.delete_at index
	end
	
	def get_k_n_student_short_list k, n
		k_n_objs = obj_array[k...(k+n)]
		k_n_objs.map! { |obj| StudentShort.student_ctor obj }
		
		DataListStudentShort.new k_n_objs
	end
	
	def sort_si
		obj_array.sort_by! {|obj| obj.surname_initials}
	end
	
	def get_students_count
		obj_array.size
	end
	
	private
	def read_obj str
		Student.string_ctor str
	end
	
	def write_obj obj
		Student.inspect obj
	end
	
end