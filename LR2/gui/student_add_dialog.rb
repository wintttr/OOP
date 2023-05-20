class StudentAddDialog < FXDialogBox
    attr_accessor :surname, :first_name, :mid_name
    attr_accessor :phone, :telegram, :email
    attr_accessor :git
    
    attr_accessor :add_btn, :back_btn

    def initialize(parent)
        super(parent, "StudentAddWindow" , :width => 250, :height => 300)
        
        vframe = FXVerticalFrame.new(self)
        
        self.add_field(vframe, :surname, "Фамилия")
        self.add_field(vframe, :first_name, "Имя")
        self.add_field(vframe, :mid_name, "Отчество")
        self.add_field(vframe, :phone, "Телефон")
        self.add_field(vframe, :telegram, "Телеграм")
        self.add_field(vframe, :email, "Мейл")
        self.add_field(vframe, :git, "Гит")
        
        hFrame = FXHorizontalFrame.new(vframe)
        self.add_btn = FXButton.new(hFrame, "Добавить")
        self.back_btn = FXButton.new(hFrame, "Отмена")
    end
    
    def create
		super
		show(PLACEMENT_SCREEN)
	end
    
    def add_field(frame, field_sym, field_name)
        hFrame = FXHorizontalFrame.new(frame)
        label = FXLabel.new(hFrame, field_name)
        
        self.method(:"#{field_sym}=").call(FXTextField.new(hFrame, 10))
    end
end