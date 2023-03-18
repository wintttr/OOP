require "json"

require_relative "basic_students_file"

class JSONReader < BasicReader
	public_class_method :new

	private
	def self.parse str
		JSON.parse str
	end
end
	
class JSONWriter < BasicWriter
	public_class_method :new

	private
	def self.esrap data_array
		JSON.pretty_generate(data_array)
	end
end