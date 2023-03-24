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

	def self.read_objects file
		file_str = file.read()
		
		data_hash = self.parse(file_str)
		
		data_hash.map do |obj_hash|
			Student.new(**obj_hash)
		end
	end
	
	def self.write_objects array, file
		data_hash = array.map do |obj|
			obj.map{ |field, value|
				[field, value]
			}.to_h
		end
		
		# esrap - это parse наоборот...
		file.puts(self.esrap(data_hash))
	end
end

class StudentsList
	# Геттеры и сеттеры
	attr_accessor :obj_array
	
	def initialize
		self.obj_array = []
	end
	
	def read_all_objects reader, file
		File.open(file) do |f|
			self.obj_array = reader.read_objects f
		end
	end
	
	def write_all_objects writer, file
		File.open(file, "w") do |f|
			writer.write_objects self.obj_array, f
		end
	end
	
	def add_obj obj
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
	
	def get_k_n_student_short_list k, n
		k_n_objs = self.obj_array[k...(k+n)]
		k_n_objs.map! { |obj| StudentShort.student_ctor obj }
		
		DataListStudentShort.new k_n_objs
	end
	
	def sort_si
		self.obj_array.sort_by! {|obj| obj.surname_initials}
	end
	
	def get_students_count
		self.obj_array.size
	end
	
	private
	def get_index id
		index = self.obj_array.find_index {|item| item.id == id}
		
		if index.nil? then 
			raise ObjectNotFound, id 
		end
		
		index
	end
end