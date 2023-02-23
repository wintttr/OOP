class Student
    attr_accessor :id
    attr_accessor :surname, :first_name, :mid_name
    attr_accessor :phone, :telegram, :mail, :git

    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, mail:nil, git:nil)
        self.id = id

		if Student.full_name_correct? surname, first_name, mid_name then
			self.surname = surname.capitalize
			self.first_name = first_name.capitalize
			self.mid_name = mid_name.capitalize
		else
			raise ArgumentError, "Wrong student name format"
		end

		if phone == nil or Student.phone_correct? phone then 
        	self.phone = phone
		else
			raise ArgumentError, "#{phone} - wrong phone number format"
		end

		if telegram == nil or Student.telegram_correct? telegram then
			self.telegram = telegram
		else
			raise ArgumentError, "#{telegram} - wrong telegram nickname format"
		end

		if mail == nil or Student.email_correct? mail then	
        	self.mail = mail
		else
			raise ArgumentError, "#{mail} - wrong email format"
		end
		
		self.git = git
    end

	# Проверка имени на корректность
	def Student.name_correct? name
		name_re = /^[а-яА-Я]+$/

		name =~ name_re
	end

	def Student.full_name_correct? surname, firstname, midname
		Student.name_correct? surname and
		Student.name_correct? firstname and
		Student.name_correct? midname
	end

	# Проверка номера телефона на корректность
	def Student.phone_correct? phone
		phone_number_re = /^(\+\d|8) ?(\(\d{3}\)|\d{3}) ?\d{3}-?\d{2}-?\d{2}$/

		phone =~ phone_number_re
	end

	# Проверка телеграма на корректность
	def Student.telegram_correct? tg
		telegram_re = /^\@[a-zA-Z]([a-zA-Z]|\d|_){4,32}$/

		tg =~ telegram_re
	end

	# Проверка мейла на корректность
	def Student.email_correct? email
		email_re = /^[a-zA-Z0-9._]+\@[a-zA-Z0-9.]+\.[a-z]+$/

		email =~ email_re
	end


	# Соединяет строки из массива запятой, пропуская элементы содержащие nil
	# Если итоговая строка пустая, возвращает nil
	def Student.join_with_comma str_arr
		result = str_arr.compact.join(", ")
		result.empty? ? nil : result  
	end

	def Student.field_string prompt, field
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