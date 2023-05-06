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
		if(value > self.page_count or value < 1)
			raise Exception, "Page #{value} not in interval [1, #{self.page_count}]"
		end
		
		@cur_page = value
		self.window.cur_page_label.text = self.cur_page.to_s
	end
	
	def page_count= value
		if(value < 1)
			raise Exception, "Page count must be positive"
		end
		
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
				puts "#{i}, #{j}"
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
	
	def refresh
		self.controller.refresh_data self.cur_page - 1, self.class.table_row_count
	end
	
	def initialize
		app = FXApp.new
		
		self.window = StudentMainWindow.new(app)
		self.controller = StudentListController.new(self)
		
		self.set_table_handlers
		self.set_lcr_handlers
		
		self.cur_page = 1
		
		self.refresh
		
		app.create 
		app.run
	end
end