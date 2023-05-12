require "student_list_view.rb"
require "students_list.rb"
require "json_reader_writer.rb"
require "db_singleton.rb"

class StudentListController
	attr_accessor :view, :student_list, :list, :dlss
	
	def default_readerwriter
		DBReaderWriter.new table: "students", db: DBSingleton.instance.db_client
	end
	
	def initialize view
		self.view = view
		self.list = StudentsList.new
		
		self.load_list self.default_readerwriter
		
		self.dlss = self.list.get_k_n_student_short_list 0, self.view.class.table_row_count
		self.dlss.view = self.view
		
		self.view.page_count = (self.list.size.to_f / self.view.class.table_row_count).ceil
	end
	
	def sort
		self.list.sort_si
	end
	
	def load_list readerwriter
		begin
			self.list.read_all_objects readerwriter
		rescue ReadError => re
			raise ViewError, "Objects reading error"
		end
	end
	
	def refresh_data page_number, row_count, reload: false
		if(reload) then
			self.load_list self.default_readerwriter
		end
	
		self.list.get_k_n_student_short_list page_number, row_count, data_list: dlss
	
		self.dlss.notify
	end
end