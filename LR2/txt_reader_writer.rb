require_relative "basic_students_file"


class TXTReader < BasicReader
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
end
	
class TXTWriter < BasicWriter
	public_class_method :new
	
	private 
	def self.esrap data_array
		data_array.map do |obj_hash|
			self.obj_to_str(Student.new(**obj_hash))
		end
	end
	
	def self.obj_to_str obj
		obj.inspect
	end
end