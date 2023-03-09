require_relative "basic_student"
require_relative "field_re"

class Student < BasicStudent
    attr_accessor :id
    attr_reader :surname, :first_name, :mid_name
    attr_reader :phone, :telegram, :email, :git
	
	def surname= value
		check_correctness :surname, value, self.class.method(:name_correct?), "Wrong student name format", false
	end
	
	def first_name= value
		check_correctness :first_name, value, self.class.method(:name_correct?), "Wrong student name format", false
	end
	
	def mid_name= value
		check_correctness :mid_name, value, self.class.method(:name_correct?), "Wrong student name format", false
	end
	
	def phone= value
		check_correctness :phone, value, self.class.method(:phone_correct?), "#{value} - wrong phone format"
	end
	
	def git= value
		check_correctness :git, value, self.class.method(:git_correct?), "Wrong git format"
	end
	
	def telegram= value
		check_correctness :telegram, value, self.class.method(:telegram_correct?), "#{value} - wrong telegram nickname format"
	end
	
	def email= value
		check_correctness :email, value, self.class.method(:email_correct?), "#{value} - wrong mail format"
	end

    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, email:nil, git:nil)
        self.id = id

		self.surname = surname
		self.first_name = first_name
		self.mid_name = mid_name
		
		self.surname.capitalize!
		self.first_name.capitalize!
		self.mid_name.capitalize!

		self.phone = phone
		self.email = email
		self.telegram = telegram

		self.git = git
    end
	
	def surname_initials
		"#{self.surname} #{self.first_name[0]}.#{self.mid_name[0]}."
	end
	
	def contact
		[self.email, self.phone, self.telegram].compact.first
	end
	
	def get_info
		self.inspect_impl ["surname_initials", "git", "contact"]
	end
	
	# Конструктор объекта из строки
	def self.string_ctor str
		Student.string_ctor_impl str, Student.method(:new)
	end

	def validate
		self.git and
		[self.phone, self.telegram, self.email].compact.count > 0
	end

	def set_contacts (phone:nil, telegram:nil, email:nil)
		if phone != nil then
			self.phone = phone
		end 
		
		if telegram != nil then
			self.telegram = telegram
		end	
		
		if email != nil then
			self.email = email
		end
	end
	
	# смирился с тем, что ужас неисправим
	def to_s
		id = Student.pretty_represent "Ид", self.id
		surname = Student.pretty_represent "Фамилия", self.surname
		first_name = Student.pretty_represent "Имя", self.first_name
		mid_name = Student.pretty_represent "Отчество", self.mid_name
		phone = Student.pretty_represent "Телефон", self.phone
		telegram = Student.pretty_represent "Телеграм", self.telegram
		email = Student.pretty_represent "Мейл", self.email
		git = Student.pretty_represent "Гит", self.git
		
		full_name = Student.join_with_comma [surname, first_name, mid_name]
		phone_and_tg = Student.join_with_comma [phone, telegram]
		email_and_git = Student.join_with_comma [email, git]

		[id, full_name, phone_and_tg, email_and_git].compact.join "\n"
	end
	
	
	private
	# Массив всех полей класса
	def self.all_fields
		[
			"id", "surname", "first_name", "mid_name",
			"phone", "telegram", "email", "git"
		]
	end
end