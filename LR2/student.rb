require_relative "basic_student"

class NilError < RuntimeError 
end

class FormatError < RuntimeError 
end

class FieldDoesntExistError < RuntimeError
	def initialize(field)
		super "Field #{field} doesn't exist."
	end
end

class Student < BasicStudent
    attr_accessor :id, :git
    attr_reader :surname, :first_name, :mid_name
    attr_reader :phone, :telegram, :mail
	
	def surname= value
		check_correctness :surname, value, lambda {|x| Student.name_correct? x}, "Wrong student name format", false
	end
	
	def first_name= value
		check_correctness :first_name, value, lambda {|x| Student.name_correct? x}, "Wrong student name format", false
	end
	
	def mid_name= value
		check_correctness :mid_name, value, lambda {|x| Student.name_correct? x}, "Wrong student name format", false
	end
	
	def phone= value
		check_correctness :phone, value, lambda {|x| Student.phone_correct? x}, "#{value} - wrong phone format"
	end
	
	def telegram= value
		check_correctness :telegram, value, lambda {|x| Student.telegram_correct? x}, "#{value} - wrong telegram nickname format"
	end
	
	def mail= value
		check_correctness :mail, value, lambda {|x| Student.email_correct? x}, "#{value} - wrong mail format"
	end

    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, mail:nil, git:nil)
        self.id = id

		self.surname = surname.capitalize
		self.first_name = first_name.capitalize
		self.mid_name = mid_name.capitalize

		self.phone = phone
		self.mail = mail
		self.telegram = telegram

		self.git = git
    end
	
	def self.string_ctor str
		Student.string_ctor_impl str, :new
	end

	def validate
		self.git and
		[self.phone, self.telegram, self.mail].compact.count > 0
	end

	def set_contacts (phone:nil, telegram:nil, mail:nil)
		if phone != nil then
			self.phone = phone
		end 
		
		if telegram != nil then
			self.telegram = telegram
		end	
		
		if mail != nil then
			self.mail = mail
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
		mail = Student.pretty_represent "Мейл", self.mail
		git = Student.pretty_represent "Гит", self.git
		
		full_name = Student.join_with_comma [surname, first_name, mid_name]
		phone_and_tg = Student.join_with_comma [phone, telegram]
		mail_and_git = Student.join_with_comma [mail, git]

		[id, full_name, phone_and_tg, mail_and_git].compact.join "\n"
	end
	
	
	private
	def self.all_fields
		[
			"id", "surname", "first_name", "mid_name",
			"phone", "telegram", "mail", "git"
		]
	end
	
	# Проверка имени на корректность
	def self.name_correct? name
		name_re = /^[а-яА-Я]+$/
		name =~ name_re
	end

	# Проверка номера телефона на корректность
	def self.phone_correct? phone
		phone_number_re = /^(\+\d|8) ?(\(\d{3}\)|\d{3}) ?\d{3}-?\d{2}-?\d{2}$/
		phone =~ phone_number_re
	end

	# Проверка телеграма на корректность
	def self.telegram_correct? tg
		telegram_re = /^\@[a-zA-Z]([a-zA-Z]|\d|_){4,32}$/
		tg =~ telegram_re
	end

	# Проверка мейла на корректность
	def self.email_correct? email
		email_re = /^[a-zA-Z0-9._]+\@[a-zA-Z0-9.]+\.[a-z]+$/
		email =~ email_re
	end
end