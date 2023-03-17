require "json"

require_relative "basic_students_file"

class StudentsListJSON < BasicStudentsFile
	public_class_method :new

	private
	def self.parse str
		JSON.parse str
	end
	
	def self.esrap data_array
		JSON.pretty_generate(data_array)
	end
end