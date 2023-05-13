require "students_list.rb"
require "parser.rb"

class TXTReaderWriter < BasicFileReaderWriter
	public_class_method :new
	
	private
	def self.parse(str)
		str.each_line.map do |line|
			Parser.parse(line)
		end
	end
	
	def self.esrap(data_array)
		data_array.map { |obj_hash|
			Parser.unparse(obj_hash)
		}.join($/)
	end
end