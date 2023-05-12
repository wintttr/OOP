require "student_main_window.rb"
require "student_list_controller.rb"

class StudentListView
	attr_accessor :window, :controller, :list
	
	attr_reader :cur_page
	attr_reader :page_count
	
	def self.table_row_count; 10 end
	
	def set_table_params(column_names, whole_entities_count)
		self.window.table.setTableSize(whole_entities_count, 4)
		self.window.set_table_headers column_names
	end
	
	def set_table_handlers
		table = self.window.table
		chg_button = self.window.chg_button
		del_button = self.window.del_button
	
		cells_selected_handler = Proc.new do
			all_cols_selected = table.selEndColumn - table.selStartColumn + 1 == table.numColumns
			num_selected_rows = table.selEndRow - table.selStartRow + 1
				
			if num_selected_rows == 1 and all_cols_selected
				chg_button.enable
				del_button.enable
			elsif num_selected_rows > 1 and all_cols_selected
				chg_button.disable
				del_button.enable
			else
				chg_button.disable
				del_button.disable
			end
		end
	
		table.connect(SEL_SELECTED, &cells_selected_handler)
		table.connect(SEL_CHANGED, &cells_selected_handler)
		
		table.columnHeader.connect(SEL_COMMAND) do |_, _, index|
			if(index == 1)
				puts "Сортировка"
				self.sort
			else
				puts "Сортировочки пока нет..."
			end
		end
	end
	
	def set_tab_book_handler
		window.tabBook.connect(SEL_COMMAND) do |sender, selector, data|
			if(sender.current == 0) then
				self.refresh reload: true
			end
		end
	end
	
	def sort
		self.controller.sort
		self.refresh
		self.cur_page = 1
	end
	
	def last_page?
		self.cur_page >= self.page_count
	end
	
	def first_page?
		self.cur_page <= 1
	end
	
	def cur_page= value
		@cur_page = value
		self.window.cur_page_label.text = self.cur_page.to_s
	end
	
	def page_count= value
		@page_count = value
		self.window.page_count_label.text = self.page_count.to_s
	end
	
	def next_page
		flag = !self.last_page?
		
		if flag
			self.cur_page += 1
			self.refresh
		else
			self.cur_page = self.page_count
		end
		
		return flag
	end
	
	def prev_page
		flag = !self.first_page?
	
		if flag
			self.cur_page -= 1
			self.refresh
		else
			self.cur_page = 1
		end
		
		return flag
	end
	
	def set_lcr_handlers
		self.window.go_left_button.connect(SEL_COMMAND) do
			self.prev_page
		end
		
		self.window.go_right_button.connect(SEL_COMMAND) do
			self.next_page
		end
	end
	
	def erase_table
		for i in 0...self.window.table.numRows
			for j in 0...self.window.table.numColumns
				self.window.table.setItemText(i, j, "")
			end
		end
	end
	
	def set_table_data(data_table)
		table = self.window.table
		
		self.erase_table
		
		(0...data_table.rows).each do |x|
			if data_table.get(x, 0).nil? then break end
			
			(0...data_table.cols).each do |y|
				value = data_table.get(x, y)
				table.setItemText(x, y, value.to_s)
			end
		end
	end
	
	def refresh reload: false
		begin
			if(reload) then
				self.cur_page = 1
			end
			
			self.controller.refresh_data self.cur_page - 1, self.class.table_row_count, reload: reload
		rescue ViewError => ve
			FXMessageBox.error self.window, MBOX_OK, "Error", ve.to_s
		end
	end
	
	def initialize
		begin
			app = FXApp.new
		
			self.window = StudentMainWindow.new(app)
			
			self.set_table_handlers
			self.set_lcr_handlers
			self.set_tab_book_handler
			self.cur_page = 1
			
			app.create
		
			self.controller = StudentListController.new(self)
			self.refresh
			app.run
		rescue ViewError => ve
			FXMessageBox.error self.window, MBOX_OK, "Error", ve.to_s
			exit
		end
	end
end