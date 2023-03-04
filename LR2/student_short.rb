require_relative "student"

class ContactDoesntExistError < RuntimeError
	def initialize
		super "Contact not found"
	end
end

class StudentShort
	attr_reader :id, :surname_initials, :git, :contact
	
	def initialize(student)
		self.id = student.id
		self.surname_initials = "#{student.surname} #{student.first_name[0]}. #{student.mid_name[0]}"
		self.git = student.git
		self.contact = [student.mail, student.phone, student.telegram].compact[0]
	end
	
	def string_ctor(id, str)
		student = Student.string_ctor str
		stud_short = StudentShort.new student
		stud_short.id = id
	end
	
	def to_s
		id = StudentShort.pretty_represent "Ид", self.id
		surname_initials = StudentShort.pretty_represent "Фамилия И.О.", self.surname_initials
		git = StudentShort.pretty_represent "Гит", self.git
		contact = StudentShort.pretty_represent "Контакт", self.contact
		
		git_and_contact = StudentShort.join_with_comma [git, contact]

		[id, surname_initials, git_and_contact].compact.join "\n"
	end
	
	def self.join_with_comma str_arr
		result = str_arr.compact.join(", ")
		result.empty? ? nil : result  
	end
	
	def self.pretty_represent field_prompt, value
		if value != nil then
			"#{field_prompt}: #{value}"
		end
	end
	
	private
	attr_writer :id, :surname_initials, :git, :contact
end