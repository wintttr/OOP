require "YAML"

require_relative "basic_students_file"

class YAMLReader < BasicReader
	public_class_method :new

	private
	def self.parse str
		YAML.load str
	end
end

class YAMLWriter < BasicWriter
	public_class_method :new

	private
	def self.esrap data_array
		data_array.to_yaml
	end
end