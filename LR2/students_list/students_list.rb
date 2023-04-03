require "student.rb"
require "exceptions.rb"
require "data_list_student_short.rb"

class BasicReaderWriter
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def read_objects
		read_objects_impl
	end
	
	def write_objects hashes_array
		write_objects_impl hashes_array
	end
end

class BasicFileReaderWriter < BasicReaderWriter
	attr_accessor :file_path
	
	private :file_path, :"file_path="
	
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def initialize(file_path)
		self.file_path = file_path
	end
	
	def read_objects_impl
		file_str = File.open(self.file_path, "r") do |file|
			file.read()
		end
		
		self.class.parse(file_str)
	end
	
	
	def write_objects_impl hashes_array
		File.open(self.file_path, "w") do |file|
			# esrap - это parse наоборот...
			file.puts(self.class.esrap(hashes_array))
		end
	end
end

class StudentsList
	# Геттеры и сеттеры
	attr_accessor :obj_array
	
	def initialize
		self.obj_array = []
	end
	
	def read_all_objects reader
		hashes_array = reader.read_objects
		
		self.obj_array = Array.new hashes_array.map {|h| Student.new(**h)}
	end
	
	def write_all_objects writer
		hashes_array = self.obj_array.map do |obj|
			obj.to_h do |field, value| 
				[field, value] 
			end
		end
	
		writer.write_objects hashes_array
	end
	
	def add_obj obj
		obj.id = self.make_new_id
		self.obj_array.append obj
	end
	
	
	def get_obj id
		index = self.get_index id
		self.obj_array[index]
	end
	
	
	def upd_obj id, obj
		index = self.get_index id
		self.obj_array[index] = obj
	end
	
	def del_obj id
		index = self.get_index id
		self.obj_array.delete_at index
	end
	
	def get_k_n_student_short_list(k, n, data_list:nil)
		k_n_objs = self.obj_array[k*n...(k*n + n)]
		k_n_objs.map! { |obj| StudentShort.student_ctor obj }
		
		return_list = DataListStudentShort.new k_n_objs
		
		unless data_list.nil? then
			data_list.array = return_list
		end
		
		return_list
	end
	
	def sort_si
		self.obj_array.sort_by! {|obj| obj.surname_initials}
	end
	
	def get_students_count
		self.obj_array.size
	end
	
	private
	def make_new_id
		self.obj_array.max { |obj| obj.id } + 1
	end
	
	def get_index id
		index = self.obj_array.find_index {|item| item.id == id}
		
		if index.nil? then 
			raise ObjectNotFound, id 
		end
		
		index
	end
end