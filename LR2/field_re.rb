class FieldRE
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
	
	# Проверка гита на корректность
	def self.git_correct? git
		true # когда-нибудь тут появится нормальная проверка...
	end
	
	# Проверка фамилии и инициалов на корректность
	def self.surname_in_correct? surname_initials
		surname_initials_re = /^[А-Я][а-я]+ [А-Я]\.[А-Я]\.$/
		surname_initials =~ surname_initials_re
	end
	
	def self.contact_correct? contact
		[ (self.phone_correct? contact), (self.telegram_correct? contact), (self.email_correct? contact) ].one? {|x| x != nil}
	end
end