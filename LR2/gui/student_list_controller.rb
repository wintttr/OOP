require "student_list_view.rb"
require "students_list.rb"
require "json_reader_writer.rb"

class StudentListController
	attr_accessor :view, :student_list, :list, :dlss
	
	def initialize view
		self.view = view
		self.list = StudentsList.new
		
		self.list.read_all_objects JSONReaderWriter.new "json_for_test.json"
		
		self.dlss = self.list.get_k_n_student_short_list 0, self.view.window.class.table_row_count
		self.dlss.view = self.view
		
		self.view.set_table_pages self.list.size
	end
	
	def refresh_data page_number, row_count
		self.list.get_k_n_student_short_list page_number, row_count, data_list: dlss
		
		self.dlss.notify
	end
end