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
	
	# Конструктор объекта StudentShort из объекта Student
	def initialize(student)
		self.id = student.id
		self.surname_initials = "#{student.surname} #{student.first_name[0]}.#{student.mid_name[0]}."
		self.git = student.git
		self.contact = [student.mail, student.phone, student.telegram].compact[0]
	end
	
	# Конструктор объекта из хэша
	def hash_ctor(id:,surname_initials:,git:,contact:)
		self.id = id
		self.surname_initials = surname_initials
		self.git = git
		self.contact = contact
	end
	
	# Конструктор объекта из строки
	def self.string_ctor(id, str)
		r = StudentShort.string_ctor_impl str, :hash_ctor
		r.id = id
		r
	end
	
	def to_s
		id = StudentShort.pretty_represent "Ид", self.id
		surname_initials = StudentShort.pretty_represent "Фамилия И.О.", self.surname_initials
		git = StudentShort.pretty_represent "Гит", self.git
		contact = StudentShort.pretty_represent "Контакт", self.contact
		
		git_and_contact = StudentShort.join_with_comma [git, contact]

		[id, surname_initials, git_and_contact].compact.join "\n"
	end
	
	private
	def all_fields
		[
			"id", "surname_initials", "git", "contact"
		]
	end
	
	attr_writer :id
	
	def surname_initials= value
		check_correctness :surname_initials, value, lambda{|x| FieldRE.surname_in_correct? x}, "Wrong surname with initials format", false
	end
	
	def git= value
		check_correctness :git, value, lambda{|x| FieldRE.git_correct? x}, "Wrong git format", false
	end
	
	def contact= value
		check_correctness :contact, value, lambda{|x| FieldRE.contact_correct? x}, "Wrong contact format", false
	end
end