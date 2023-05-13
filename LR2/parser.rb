module Parser
	def self.parse(str)
		fields = str.split(/,/)
		field_init_re = /^(.+):\{(.+)\}$/

		# проверяем, все ли поля соответствуют определённому формату
		if fail_string = fields.filter { |field| not(field =~ field_init_re) }.first then
			raise(FormatError, fail_string)
		end
		
		# смирился с тем, что ужас неисправим
		fields.map { |field|
			matches = field.match(field_init_re)
			[matches[1].to_sym, matches[2]]
		}.to_h
	end
	
	def self.unparse(data_hash)
		data_hash.filter{ |k, v|
			not v.nil? 
		}.map { |k, v|
			"#{k}:\{#{v}\}"
		}.join(",")
	end
end