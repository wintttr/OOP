module CheckCorrectnessWriter
	# Создаёт сеттер, проверяющий value на условие correct
	def checked_writer(field, correct, nil_expected: true, preprocess: lambda {|x| x})
		define_method("#{field}=") do |value| 
			field_sym = "@#{field}".to_sym

			if value == nil then
				if nil_expected then
					instance_variable_set field_sym, nil
				else
					raise NilError, field
				end
			elsif correct.call value then
				instance_variable_set field_sym, preprocess.call(value)
			else
				raise ArgumentError, "#{value} - wrong format for field #{field}"
			end
		end
	end
end