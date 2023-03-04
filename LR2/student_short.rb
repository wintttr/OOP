require_relative "basic_student"
require_relative "student"

class ContactDoesntExistError < RuntimeError
	def initialize
		super "Contact not found"
	end
end

class StudentShort < BasicStudent
	attr_reader :id, :surname_initials, :git, :contact
	
	def initialize(student)
		self.id = student.id
		self.surname_initials = "#{student.surname} #{student.first_name[0]}. #{student.mid_name[0]}"
		self.git = student.git
		self.contact = [student.mail, student.phone, student.telegram].compact[0]
	end
	
	def ctor(id:,surname_initials:,git:,contact:)
		self.id = id
		self.surname_initials = surname_initials
		self.git = git
		self.contact = contact
	end
	
	def self.string_ctor(id, str)
		r = StudentShort.string_ctor_impl str, :ctor
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
	
	attr_writer :id, :surname_initials, :git, :contact
end