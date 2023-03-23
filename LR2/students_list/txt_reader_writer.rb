require "students_list.rb"


class TXTReaderWriter < BasicReaderWriter
	public_class_method :new

	private
	def self.parse str
		str.each_line.map do |line|
			self.str_to_obj(line)
		end
	end
	
	def self.str_to_obj str
		Student.string_ctor str
	end
	
	def self.esrap data_array
		data_array.map do |obj_hash|
			self.obj_to_str(Student.new(**obj_hash))
		end
	end
	
	def self.obj_to_str obj
		obj.inspect
	end
end