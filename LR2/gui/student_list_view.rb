require "student_main_window.rb"
require "student_list_controller.rb"

class StudentListView
	attr_accessor :window, :controller, :list
	
	def initialize
		app = FXApp.new
		
		self.window = StudentMainWindow.new(app, self.method(:refresh))
		self.controller = StudentListController.new(self)
		self.refresh
		
		app.create 
		app.run
	end
	
	def set_table_pages value
		self.window.page_count = (value.to_f / StudentMainWindow.table_row_count).ceil
	end
	
	def set_table_params(column_names, whole_entities_count)
		self.window.table.setTableSize(whole_entities_count, 4)
		self.window.set_table_headers column_names
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
		self.controller.refresh_data self.window.cur_page - 1, StudentMainWindow.table_row_count
	end
end