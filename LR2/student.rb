class NilError < RuntimeError
end

class Student
    attr_accessor :id, :git
    attr_reader :surname, :first_name, :mid_name
    attr_reader :phone, :telegram, :mail
	
	def check_correctness field, value, correct, err_string, nil_expected = true
		if value == nil and nil_expected then
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

	def surname= value
		check_correctness :@surname, value, lambda {|x| Student.name_correct? x}, "Wrong student name format", false
	end
	
	def first_name= value
		check_correctness :@first_name, value, lambda {|x| Student.name_correct? x}, "Wrong student name format", false
	end
	
	def mid_name= value
		check_correctness :@mid_name, value, lambda {|x| Student.name_correct? x}, "Wrong student name format", false
	end
	
	def phone= value
		check_correctness :@phone, value, lambda {|x| Student.phone_correct? x}, "#{value} - wrong phone format"
	end
	
	def telegram= value
		check_correctness :@telegram, value, lambda {|x| Student.telegram_correct? x}, "#{value} - wrong telegram nickname format"
	end
	
	def mail= value
		check_correctness :@mail, value, lambda {|x| Student.email_correct? x}, "#{value} - wrong mail format"
	end

    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, mail:nil, git:nil)
        self.id = id

		self.surname = surname.capitalize
		self.first_name = first_name.capitalize
		self.mid_name = mid_name.capitalize

		set_contacts phone: phone, mail: mail, telegram: telegram 
		
		self.git = git
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
			self.telegram =  telegram
		end	
		
		if mail != nil then
			self.mail = mail
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

	def self.field_string prompt, field
		if field != nil then
			"#{prompt}: #{field}"
		end
	end
	
	def to_s
		id = Student.field_string "Ид", self.id
		surname = Student.field_string "Фамилия", self.surname
		first_name = Student.field_string "Имя", self.first_name
		mid_name = Student.field_string "Отчество", self.mid_name
		phone = Student.field_string "Телефон", self.phone
		telegram = Student.field_string "Телеграм", self.telegram
		mail = Student.field_string "Мейл", self.mail
		git = Student.field_string "Гит", self.git
		
		full_name = Student.join_with_comma [surname, first_name, mid_name]
		phone_and_tg = Student.join_with_comma [phone, telegram]
		mail_and_git = Student.join_with_comma [mail, git]

		[id, full_name, phone_and_tg, mail_and_git].compact.join "\n"
	end
end