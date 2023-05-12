class ReadError < RuntimeError; end

class ViewError < RuntimeError
	def initialize error
		super error
	end
end

class ContactDoesntExistError < RuntimeError
	def initialize
		super "No contact found"
	end
end

class NilError < RuntimeError
	def initialize field
		super "Field #{field} can't be nil"
	end
end

class FormatError < RuntimeError
	def initialize field
		super "Format error occured while processing the string: \"#{field}\""
	end
end

class FieldDoesntExistError < RuntimeError
	def initialize(field)
		super "Field #{field} doesn't exist."
	end
end

class FileDoesntExistError < IOError
	def initialize file
		super "File #{file} doesn't exist"
	end
end

class ObjectNotFound < RuntimeError
	def initialize id
		super "Object with id #{id} not found"
	end
end