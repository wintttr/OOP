require "YAML"

require_relative "basic_students_file"

class StudentsListYAML < BasicStudentsFile
	public_class_method :new

	private
	def self.parse str
		YAML.load str
	end
	
	def self.esrap data_array
		data_array.to_yaml
	end
end