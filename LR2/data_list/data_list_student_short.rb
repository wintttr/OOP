require "data_list.rb"
require "data_table.rb"
require "student_short.rb"

class DataListStudentShort < DataList
	public_class_method :new
	
	attr_accessor :view
	
	def notify
		self.view.set_table_params(self.get_names_impl.map{|x| x.to_s}, self.array.size)
		self.view.set_table_data(self.get_data)
	end
	
	private
	def get_names_impl
		beautyful_names = {:surname_initials => "Фамилия И.О.", :git => "Гит", :contact => "Контакт"}
		(StudentShort.all_fields - [:id]).map { |field| beautyful_names[field]}
	end
	
	def get_data_impl
		self.array.map do |student|
			student[0].filter{|field, value| field != :id}.map{|field, value| value}
		end
	end
end