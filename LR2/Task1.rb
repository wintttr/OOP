class Student
    attr_accessor :id
    attr_accessor :surname, :first_name, :mid_name
    attr_accessor :phone, :telegram, :mail, :git

    def initialize(surname, first_name, mid_name, id=nil, phone=nil, telegram=nil, mail=nil, git=nil)
        self.id = id
        self.surname = surname
        self.first_name = first_name
        self.mid_name = mid_name
        self.phone = phone
        self.telegram = telegram
        self.mail = mail
        self.git = git
    end
end