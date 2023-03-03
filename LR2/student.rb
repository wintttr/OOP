class NilError < RuntimeError 
end

class FormatError < RuntimeError 
end

class FieldDoesntExistError < RuntimeError
	def initialize(field)
		super "Field #{field} doesn't exist."
	end
end

class Student
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

	# исправить ужас
	def self.string_ctor str
		fields = str.split(/,/)
		field_init_re = /^(.+):\{(.+)\}$/
		field_value_hash = {}

		# исправить ужас
		fields.each do |field|
			if not (field =~ field_init_re) then
				raise FormatError
			end

			matches = field.match field_init_re
			
			if not Student.all_fields.include? matches[1] then 
				raise FieldDoesntExistError, matches[1]
			end 

			field_value_hash[matches[1].to_sym] = matches[2]
		end
		
		Student.new **field_value_hash
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
	
	# исправить ужас
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
	
	# исправить ужас
	def inspect
		id = inspect_represent :id
		surname = inspect_represent :surname
		first_name = inspect_represent :first_name
		mid_name = inspect_represent :mid_name
		phone = inspect_represent :phone
		telegram = inspect_represent :telegram
		mail = inspect_represent :mail
		git = inspect_represent :git

		[id, surname, first_name, mid_name, phone, telegram, mail, git].compact.join ","
	end
	
	private
	
	def self.all_fields
		[
			"id", "surname", "first_name", "mid_name",
			"phone", "telegram", "mail", "git"
		]
	end

	def check_correctness field, value, correct, err_string, nil_expected = true
		field = "@#{field}".to_sym

		if value == nil then
			if nil_expected then
				instance_variable_set field, nil
			else
				raise NilError
			end
		elsif correct.call value then
        	instance_variable_set field, value
		else
			raise ArgumentError, err_string
		end
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

	# Соединяет строки из массива запятой, пропуская элементы содержащие nil
	# Если итоговая строка пустая, возвращает nil
	def self.join_with_comma str_arr
		result = str_arr.compact.join(", ")
		result.empty? ? nil : result  
	end

	def self.pretty_represent field_prompt, value
		if value != nil then
			"#{field_prompt}: #{value}"
		end
	end

	# исправить ужас
	def inspect_represent field
		value = instance_variable_get "@#{field}".to_sym

		if value != nil then
			"#{field}:\{#{value}\}"
		end
	end 
end