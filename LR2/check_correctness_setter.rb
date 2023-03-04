module CheckCorrectnessSetter
	protected
	
	# Создаёт сеттер, которые проверяет value на условие correct
	# если условие не выполняется, кидает исключение с текстом err_string
	def check_correctness field, value, correct, err_string, nil_expected = true
		field = "@#{field}".to_sym

		if value == nil then
			if nil_expected then
				instance_variable_set field, nil
			else
				raise NilError, field
			end
		elsif correct.call value then
        	instance_variable_set field, value
		else
			raise ArgumentError, err_string
		end
	end
end