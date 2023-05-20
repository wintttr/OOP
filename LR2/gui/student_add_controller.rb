class StudentAddController
    attr_accessor :view
    attr_accessor :controller
    attr_accessor :student
    
    def initialize(view)
        self.view = view
    end
    
    def validate_fields
        begin
            fields = {
                :id => 0,
                :surname => self.view.surname,
                :first_name => self.view.first_name,
                :mid_name => self.view.mid_name,
                :phone => (if self.view.phone.strip.empty? then nil else self.view.phone end),
                :email => (if self.view.email.strip.empty? then nil else self.view.email end),
                :telegram => (if self.view.telegram.strip.empty? then nil else self.view.telegram end),
                :git => (if self.view.git.strip.empty? then nil else self.view.git end)
            }
            
            self.student = Student.new(**fields)
            return self.student

        rescue ArgumentError => e
            return nil
        end
    end
end