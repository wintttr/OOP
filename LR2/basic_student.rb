require_relative "check_correctness_setter"

class NilError < RuntimeError
	def initialize field
		super "Field #{field} can't be nil"
	end
end

class FormatError < RuntimeError
end

class FieldDoesntExistError < RuntimeError
	def initialize(field)
		super "Field #{field} doesn't exist."
	end
end

class FileDoesntExistError < IOError
end

class BasicStudent
	include CheckCorrectnessSetter
	
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
	
	# смирился с тем, что ужас неисправим
	def self.string_ctor_impl str, ctor
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
		
		ctor.call **field_value_hash
	end
	
	# Сериализуем (о какое слово знаю!) объект в формате "field:{value},..."
	def inspect
		self.inspect_impl self.class.all_fields
	end

	protected
	def self.contact_type contact
		if FieldRE.phone_correct? contact then "phone"
		elsif FieldRE.email_correct? contact then "email"
		elsif FieldRE.telegram_correct? contact then "telegram"
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
		value = eval("self.#{field}")

		if value != nil then
			"#{field}:\{#{value}\}"
		end
	end 
end