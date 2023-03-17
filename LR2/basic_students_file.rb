require_relative "student"
require_relative "exceptions"
require_relative "data_list_student_short"


class BasicStudentsFile
	attr_accessor :obj_array
	
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def initialize
		self.obj_array = []
	end
	
	def read_all_objects file
		file_str = File.read(file)
		
		data_hash = self.parse(file_str)
		
		obj_array = data_hash.map do |obj_hash|
			Student.new(**obj_hash)
		end
	end
	
	def write_all_objects file
		data_hash = array.map do |obj|
			obj.map do |field, value|
				field => value
			end
		end
		
		File.open(file) do |f|
			# esrap - это parse наоборот...
			f.puts(self.esrap(data_hash))
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
end