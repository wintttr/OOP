require_relative "basic_student"
require_relative "student"
require_relative "field_re"

class ContactDoesntExistError < RuntimeError
	def initialize
		super "Contact not found"
	end
end

class StudentShort < BasicStudent
	attr_reader :id, :surname_initials, :git, :contact
	
	# Конструктор объекта из хэша
	def initialize(id:nil,surname_initials:,git:,contact:)
		self.id = id
		self.surname_initials = surname_initials
		self.git = git
		self.contact = contact
	end
	
	# Конструктор объекта StudentShort из объекта Student
	def self.student_ctor(student)
		options = {
			:id => student.id,
			:surname_initials => student.surname_initials,
			:git => student.git,
			:contact => student.contact
		}
		
		self.new **options
	end
	
	# Конструктор объекта из id и строки
	def self.id_string_ctor(id, str)
		options = self.get_field_value_hash str
		options["id"] = id
		
		self.new **options
	end
	
	def self.string_ctor str
		StudentShort.string_ctor_impl str, StudentShort.method(:new)
	end
	
	def to_s
		id = StudentShort.pretty_represent "Ид", self.id
		surname_initials = StudentShort.pretty_represent "Фамилия И.О.", self.surname_initials
		git = StudentShort.pretty_represent "Гит", self.git
		contact = StudentShort.pretty_represent "Контакт", self.contact
		contact_type = StudentShort.pretty_represent "Тип контакта", (self.class.contact_type self.contact)
		
		git_and_contact = StudentShort.join_with_comma [git, contact]

		[id, surname_initials, git_and_contact, contact_type].compact.join "\n"
	end
	
	private
	def self.all_fields
		[
			"id", "surname_initials", "git", "contact"
		]
	end
	
	attr_writer :id
	
	def surname_initials= value
		check_correctness :surname_initials, value, FieldRE.method(:surname_in_correct?), "Wrong surname with initials format", false
	end
	
	def git= value
		check_correctness :git, value, FieldRE.method(:git_correct?), "Wrong git format", false
	end
	
	def contact= value
		check_correctness :contact, value, FieldRE.method(:contact_correct?), "Wrong contact format", false
	end
end