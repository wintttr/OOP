require "basic_student.rb"
require "student.rb"
require "exceptions.rb"

class StudentShort < BasicStudent
	attr_reader :surname_initials, :contact
	public :id, :git
	private :"id=", :"git="
	
	public_class_method :new
	
	# Конструктор объекта StudentShort из объекта Student
	def self.student_ctor(student)
		options = {
			:id => student.id,
			:surname_initials => student.surname_initials,
			:git => student.git,
			:contact => student.contact
		}
		
		self.new(**options)
	end
	
	# Конструктор объекта из id и строки
	def self.id_string_ctor(id, str)
		options = self.get_field_value_hash str
		options[:id] = id
		
		self.new(**options)
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
	
	
	def self.all_fields
		[
			"id", "surname_initials", "git", "contact"
		]
	end
	
	
	private
	
	# Конструктор объекта из хэша
	def initialize(id:, surname_initials:, git:, contact:)
		self.id = id
		self.surname_initials = surname_initials
		self.git = git
		self.contact = contact
	end
	
	checked_writer :surname_initials, self.method(:surname_in_correct?), nil_expected: false
	checked_writer :contact, self.method(:contact_correct?), nil_expected: false
end