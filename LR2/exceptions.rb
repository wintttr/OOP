class ContactDoesntExistError < RuntimeError
	def initialize
		super "Contact not found"
	end
end

class NilError < RuntimeError
	def initialize field
		super "Field #{field} can't be nil"
	end
end

class FormatError < RuntimeError
end

class FieldDoesntExistError < RuntimeError
	def initialize(field)
		super "Field #{field} doesn't exist."
	end
end

class FileDoesntExistError < IOError
end