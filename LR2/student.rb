class Student
    attr_accessor :id
    attr_accessor :surname, :first_name, :mid_name
    attr_accessor :phone, :telegram, :mail, :git

    def initialize(surname:, first_name:, mid_name:, id:nil, phone:nil, telegram:nil, mail:nil, git:nil)
        self.id = id
        self.surname = surname
        self.first_name = first_name
        self.mid_name = mid_name
        self.phone = phone
        self.telegram = telegram
        self.mail = mail
        self.git = git
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