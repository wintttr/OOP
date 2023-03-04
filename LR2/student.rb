require_relative "basic_student"
require_relative "field_re"

class Student < BasicStudent
    attr_accessor :id
    attr_reader :surname, :first_name, :mid_name
    attr_reader :phone, :telegram, :mail, :git
	
	def surname= value
		check_correctness :surname, value, lambda {|x| FieldRE.name_correct? x}, "Wrong student name format", false
	end
	
	def first_name= value
		check_correctness :first_name, value, lambda {|x| FieldRE.name_correct? x}, "Wrong student name format", false
	end
	
	def mid_name= value
		check_correctness :mid_name, value, lambda {|x| FieldRE.name_correct? x}, "Wrong student name format", false
	end
	
	def phone= value
		check_correctness :phone, value, lambda {|x| FieldRE.phone_correct? x}, "#{value} - wrong phone format"
	end
	
	def git= value
		check_correctness :git, value, lambda{|x| FieldRE.git_correct? x}, "Wrong git format"
	end
	
	def telegram= value
		check_correctness :telegram, value, lambda {|x| FieldRE.telegram_correct? x}, "#{value} - wrong telegram nickname format"
	end
	
	def mail= value
		check_correctness :mail, value, lambda {|x| FieldRE.email_correct? x}, "#{value} - wrong mail format"
	end

    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, mail:nil, git:nil)
        self.id = id

		self.surname = surname
		self.first_name = first_name
		self.mid_name = mid_name
		
		self.surname.capitalize!
		self.first_name.capitalize!
		self.mid_name.capitalize!

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
end