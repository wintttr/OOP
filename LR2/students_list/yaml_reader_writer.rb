require "YAML"

require "students_list.rb"

class YAMLReaderWriter < BasicFileReaderWriter
	public_class_method :new

	private
	def self.parse str
		YAML.load str
	end
	
	def self.esrap data_array
		data_array.to_yaml
	end
end