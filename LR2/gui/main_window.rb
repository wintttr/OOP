require 'fox16' 
include Fox 

class StudentListView < FXMainWindow
	def initialize(app)
		super(app, "StudentListView" , :width => 910, :height => 450)
		
		hFrame1 = FXHorizontalFrame.new(self)
		
		# Фамилия инициалы
		name_label = FXLabel.new(hFrame1, "Фамилия и инициалы: ")
		name_field = FXTextField.new(hFrame1, 10)
		
		# Гит
		git_label = FXLabel.new(hFrame1, "Наличие гита: ")
		git_combo = FXComboBox.new(hFrame1, 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		git_combo.appendItem("Да")
		git_combo.appendItem("Нет")
		git_combo.appendItem("Не важно")
		
		git_field_label = FXLabel.new(hFrame1, "Гит: ")
		git_field = FXTextField.new(hFrame1, 10)
		
		# Мейл
		hFrame2 = FXHorizontalFrame.new(self)
		
		email_label = FXLabel.new(hFrame2, "Наличие мейла: ")
		email_combo = FXComboBox.new(hFrame2, 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		email_combo.appendItem("Да")
		email_combo.appendItem("Нет")
		email_combo.appendItem("Не важно")
		
		email_field_label = FXLabel.new(hFrame2, "Мейл: ")
		email_field = FXTextField.new(hFrame2, 30)
		
		
		
		# Телефон
		hFrame3 = FXHorizontalFrame.new(self)
		phone_label = FXLabel.new(hFrame3, "Наличие телефона: ")
		phone_combo = FXComboBox.new(hFrame3, 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		phone_combo.appendItem("Да")
		phone_combo.appendItem("Нет")
		phone_combo.appendItem("Не важно")
		
		phone_field_label = FXLabel.new(hFrame3, "Телефон: ")
		phone_field = FXTextField.new(hFrame3, 17)
		
		
		# Телеграм
		hFrame4 = FXHorizontalFrame.new(self)
		tg_label = FXLabel.new(hFrame4, "Наличие телеграма: ")
		tg_combo = FXComboBox.new(hFrame4, 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		tg_combo.appendItem("Да")
		tg_combo.appendItem("Нет")
		tg_combo.appendItem("Не важно")
		
		tg_field_label = FXLabel.new(hFrame4, "Телеграм: ")
		tg_field = FXTextField.new(hFrame4, 10)
		
		hFrame5 = FXHorizontalFrame.new(self)
		FXLabel.new(hFrame5, "Таблица")
		
		hFrame6 = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_FIX_HEIGHT)
		hFrame6.height = 230
		table = FXTable.new(hFrame6, :opts => LAYOUT_FILL)
		table.setTableSize(10, 8)
		
		table.setColumnText(0, "ID")
		table.setColumnText(1, "Фамилия")
		table.setColumnText(2, "Имя")
		table.setColumnText(3, "Отчество")
		table.setColumnText(4, "Мейл")
		table.setColumnText(5, "Телефон")
		table.setColumnText(6, "Телеграм")
		table.setColumnText(7, "Гит")
		
		hFrame7 = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X)
		FXButton.new(hFrame7, "Добавить")
		FXButton.new(hFrame7, "Изменить")
		FXButton.new(hFrame7, "Удалить")
		FXButton.new(hFrame7, "Обновить")
		
		
		table.setItem(0, 0, FXTableItem.new("1"))
		table.setItem(0, 1, FXTableItem.new("Курбатский"))
		table.setItem(0, 2, FXTableItem.new("Владимир"))
		table.setItem(0, 3, FXTableItem.new("Не помню"))
		table.setItem(0, 4, FXTableItem.new("vova@mail.ru"))
		table.setItem(0, 5, FXTableItem.new("+79054955990"))
		table.setItem(0, 6, FXTableItem.new("@SvinZhao"))
		table.setItem(0, 7, FXTableItem.new("SeemerGG"))
	end
	
	def create
		super
		show(PLACEMENT_SCREEN)
	end
end

app = FXApp.new 
StudentListView.new(app)
app.create 
app.run 
