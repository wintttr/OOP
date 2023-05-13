require "student_list_view.rb"
require "students_list.rb"
require "json_reader_writer.rb"
require "db_singleton.rb"

class StudentListController
	def initialize view
		# Спроси зачем
		self.view = view
		self.list = StudentsList.new
		
		self.load_list self.default_readerwriter
		self.dlss = self.list.get_k_n_student_short_list 0, self.table_row_count
		
		self.dlss.view = self.view
	end

	def cur_page
		if @cur_page.nil? or @cur_page <= 1 or @cur_page >= self.page_count then @cur_page = 1 end
		
		@cur_page
	end
	
	def page_count
		if not self.list.nil? then
			(self.list.size.to_f / self.table_row_count).ceil
		else
			1
		end
	end
	
	def next_page
		self.cur_page += 1
	end
	
	def prev_page
		self.cur_page -= 1
	end
	
	def refresh_data reload: false
		if(reload) then
			self.load_list self.default_readerwriter
		end
	
		self.list.get_k_n_student_short_list self.cur_page - 1, self.table_row_count, data_list: dlss
	
		self.dlss.notify
	end
	
	def sort
		self.list.sort_si
	end
	
	
	private
	attr_accessor :view, :list, :dlss
	
	def default_readerwriter
		DBReaderWriter.new table: "students", db: DBSingleton.instance.db_client
	end
	
	def table_row_count; 10 end
	
	def last_page? page
		page >= self.page_count
	end
	
	def first_page? page
		page <= 1
	end
	
	def cur_page= value
		if last_page? value then 
			@cur_page = self.page_count
		elsif first_page? value then
			@cur_page = 1
		else
			@cur_page = value
		end
	end
	
	def load_list readerwriter
		begin
			self.list.read_all_objects readerwriter
		rescue ReadError => re
			raise ViewError, "Objects reading error"
		end
	end
end