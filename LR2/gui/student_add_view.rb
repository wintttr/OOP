require "student_add_controller"
require "student_add_dialog"

class StudentAddView
    attr_accessor :dialog
    
    def initialize(list_view, list_controller)
        main_window = list_view.window
    
        add_controller = StudentAddController.new(self)
        
        self.dialog = StudentAddDialog.new(main_window)
        
        self.dialog.add_btn.disable
        
        self.dialog.add_btn.connect(SEL_COMMAND) do
            list_controller.add_student(add_controller.student)
            
            self.dialog.handle(self.dialog.add_btn, FXSEL(SEL_COMMAND,
                               FXDialogBox::ID_ACCEPT), nil)
        end

        self.dialog.back_btn.connect(SEL_COMMAND) do
            self.dialog.handle(self.dialog.back_btn, FXSEL(SEL_COMMAND,
                               FXDialogBox::ID_CANCEL), nil)
        end
        
        [:surname, :first_name, :mid_name, 
         :phone, :telegram, :email, :git].each do |field_sym|
            field_meth = self.dialog.method(field_sym)
            
            field_meth.call.connect(SEL_COMMAND) {
                if(add_controller.validate_fields)
                    self.dialog.add_btn.enable
                else
                    self.dialog.add_btn.disable
                end
            }
        end
    end
    
    def execute
        return self.dialog.execute
    end
    
    def surname() self.dialog.surname.text end
    def first_name() self.dialog.first_name.text end
    def mid_name() self.dialog.mid_name.text end
    def phone() self.dialog.phone.text end
    def telegram() self.dialog.telegram.text end
    def email() self.dialog.email.text end
    def git() self.dialog.git.text end
end