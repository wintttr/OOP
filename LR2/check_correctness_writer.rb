module CheckCorrectnessWriter
	# Создаёт сеттер, проверяющий value на условие correct
	# В correct_sym передаётся символ метода, который сначала ищется в
	# методах класса, а затем в методах объекта
	def checked_writer(field, correct_sym, nil_expected: true, preprocess: lambda {|x| x})
		define_method("#{field}=") do |value| 
			field_sym = "@#{field}".to_sym
			
			if self.class.respond_to?(correct_sym) then
				correct_method = self.class.method(correct_sym)
			elsif self.class.method_defined?(correct_sym) then
				correct_method = self.class.instance_method(correct_sym).bind(self)
			end
			
			if value == nil then
				if nil_expected then
					instance_variable_set field_sym, nil
				else
					raise NilError, field
				end
			elsif correct_method.call value then
				instance_variable_set field_sym, preprocess.call(value)
			else
				raise ArgumentError, "#{value} - wrong format for field #{field}"
			end
		end
	end
end