require "main_window.rb"

class StudentListView
	attr_accessor :window, :controller
	
	def initialize controller_class
		self.controller = controller_class.new(self)
		
		app = FXApp.new 
		StudentMainWindow.new(app)
		app.create 
		app.run 
	end
	
	
end