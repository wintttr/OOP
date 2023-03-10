require_relative "check_correctness_writer"
require_relative "exceptions"

class BasicStudent
	extend CheckCorrectnessWriter
	
	def self.read_from_txt file_path
		stud_list = []
		
		unless FileTest::exist? file_path then
			raise FileDoesntExistError
		end
		
		File.readlines(file_path).each do |line|
			unless line.empty? then
				stud_list.append self.string_ctor line
			end
		end
		
	end
	
	def self.write_to_txt file_path, stud_list
		File.open file_path, "w" do |file|
			stud_list.each do |student|
				file.puts student.inspect
			end
		end
	end
	
	# Сериализуем (о какое слово знаю!) объект в формате "field:{value},..."
	def inspect
		self.inspect_impl self.class.all_fields
	end

	protected
	# смирился с тем, что ужас неисправим
	def self.string_ctor_impl str, ctor
		field_value_hash = self.get_field_value_hash str
		
		ctor.call **field_value_hash
	end
	
	def self.get_field_value_hash str
		fields = str.split(/,/)
		field_init_re = /^(.+):\{(.+)\}$/

		# проверяем, все ли поля соответствуют определённому формату
		unless fields.all? { |field| field =~ field_init_re } then
			raise FormatError
		end

		# смирился с тем, что ужас неисправим
		field_value_hash = fields.to_h do |field|
			matches = field.match field_init_re
			
			unless self.all_fields.include? matches[1] then 
				raise FieldDoesntExistError, matches[1]
			end 

			[matches[1].to_sym, matches[2]]
		end
	end
	
	def self.contact_type contact
		if self.phone_correct? contact then "phone"
		elsif self.email_correct? contact then "email"
		elsif self.telegram_correct? contact then "telegram"
		end
	end
	
	def inspect_impl fields
		fields.map{|field| inspect_represent field.to_sym}.compact.join ","
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

	# ... не знаю
	def inspect_represent field
		value = (self.method field).call

		if value != nil then
			"#{field}:\{#{value}\}"
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