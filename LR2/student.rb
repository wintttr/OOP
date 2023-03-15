require_relative "basic_student"
require_relative "exceptions"

class Student < BasicStudent
    attr_reader :surname, :first_name, :mid_name
    attr_reader :phone, :telegram, :email
	
	def self.preprocess_phone value
		new_value = value.delete "+ ()-"
		new_value[0] = "7" if new_value[0] == "8"
		
		new_value
	end
	
	checked_writer :surname, self.method(:name_correct?), nil_expected: false, preprocess: lambda {|x| x.capitalize}
	checked_writer :first_name, self.method(:name_correct?), nil_expected: false, preprocess: lambda {|x| x.capitalize}
	checked_writer :mid_name, self.method(:name_correct?), nil_expected: false, preprocess: lambda {|x| x.capitalize}
	checked_writer :phone, self.method(:phone_correct?), preprocess: self.method(:preprocess_phone)
	checked_writer :telegram, self.method(:telegram_correct?)
	checked_writer :email, self.method(:email_correct?)
	
	public :id, :git, :"id=", :"git="
	
	public_class_method :new
	
    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, email:nil, git:nil)
        self.id = id

		self.surname = surname
		self.first_name = first_name
		self.mid_name = mid_name
		
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

	def set_contacts(phone:nil, telegram:nil, email:nil)
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
	
	# Массив всех полей класса
	def self.all_fields
		[
			"id", "surname", "first_name", "mid_name",
			"phone", "telegram", "email", "git"
		]
	end
end