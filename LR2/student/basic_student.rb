require "check_correctness_writer.rb"
require "parser.rb"
require "exceptions.rb"

class BasicStudent
	extend CheckCorrectnessWriter
	include Enumerable
	
	# Геттеры и сеттеры
	attr_reader :id, :git
	checked_writer :id, :id_correct?
	checked_writer :git, :git_correct?
	
	def self.read_from_txt(file_path)
		stud_list = []
		
		unless FileTest::exist?(file_path) then
			raise(FileDoesntExistError, file_path)
		end
		
		File.readlines(file_path).each do |line|
			unless line.empty? then
				stud_list.append(self.string_ctor(line))
			end
		end
	end
	
	def self.write_to_txt(file_path, stud_list)
		File.open(file_path, "w") do |file|
			stud_list.each do |student|
				file.puts(student.inspect)
			end
		end
	end
	
	# Сериализуем (о какое слово знаю!) объект в формате "field:{value},..."
	def inspect
		field_value_hash = self.hash_from_fields(self.class.all_fields)
		Parser.unparse(field_value_hash)
	end
	
	def git_exists?
		return self.git != nil
	end
	
	def contact_exists?
		[self.phone, self.telegram, self.email].compact.count > 0
	end
	
	def validate
		self.git_exists? and self.contact_exists?
	end

	protected
	
	class << self
		protected
		def new(*wargs, **kwargs)
			super(*wargs, **kwargs)
		end
	end
	
	def hash_from_fields(fields)
		fields.to_h { |field_sym|
			[field_sym, self.method(field_sym).call]
		}
	end
	
	# Конструктор объекта из строки
	def self.string_ctor(str)
		field_value_hash = Parser.parse(str)
		
		self.new(**field_value_hash)
	end
	
	def self.contact_type(contact)
		if self.phone_correct?(contact) then "phone"
		elsif self.email_correct?(contact) then "email"
		elsif self.telegram_correct?(contact) then "telegram"
		end
	end
	
	# Соединяет строки из массива запятой, пропуская элементы содержащие nil
	# Если итоговая строка пустая, возвращает nil
	def self.join_with_comma(str_arr)
		result = str_arr.compact.join(", ")
		result.empty? ? nil : result  
	end
	
	def self.pretty_represent(field_prompt, value)
		if value != nil then
			"#{field_prompt}: #{value}"
		end
	end
	
	# ПРОВЕРОЧКИ
	# Проверка ида на корректность
	def self.id_correct?(id)
		id_re = /^\d+$/
		id.to_s =~ id_re
	end
	
	# Проверка имени на корректность
	def self.name_correct?(name)
		name_re = /^[а-яА-Я]+$/
		name =~ name_re
	end

	# Проверка номера телефона на корректность
	def self.phone_correct?(phone)
		phone_number_re = /^(\+\d|8) ?(\(\d{3}\)|\d{3}) ?\d{3}-?\d{2}-?\d{2}$/
		simple_number_re = /^\d{11}$/
		phone =~ phone_number_re or phone =~ simple_number_re
	end

	# Проверка телеграма на корректность
	def self.telegram_correct?(tg)
		telegram_re = /^\@[a-zA-Z]([a-zA-Z]|\d|_){4,32}$/
		tg =~ telegram_re
	end

	# Проверка мейла на корректность
	def self.email_correct?(email)
		email_re = /^[a-zA-Z0-9._]+\@[a-zA-Z0-9.]+\.[a-z]+$/
		email =~ email_re
	end
	
	# Проверка гита на корректность
	def self.git_correct?(git)
		git_re = /^[a-zA-Z0-9]([a-zA-Z0-9]|-(?!-))+[a-zA-Z0-9]$/
		git =~ git_re
	end
	
	# Проверка фамилии и инициалов на корректность
	def self.surname_in_correct?(surname_initials)
		surname_initials_re = /^[А-Я][а-я]+ [А-Я]\.[А-Я]\.$/
		surname_initials =~ surname_initials_re
	end
	
	def self.contact_correct?(contact)
		[ (self.phone_correct?(contact)), (self.telegram_correct?(contact)), (self.email_correct?(contact)) ].one? {|x| x != nil}
	end
	
	def each
		self.class.all_fields
			.each { |x| yield(x, self.method(x).call)}
	end
end