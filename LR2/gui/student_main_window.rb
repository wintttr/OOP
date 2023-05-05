require 'fox16'
include Fox 

class StudentMainWindow < FXMainWindow
	attr_accessor :add_button, :chg_button, :del_button, :upd_button
	attr_accessor :table
	
	# Говнокод, потом уберу
	attr_accessor :row_number
	
	def handle_list_box_command index, listbox, field
		item_text = listbox.getItemText(index)
		if(item_text == "Да")
			field.enable
		else
			field.disable
		end
	end
	
	def add_name_field frame
		name_label = FXLabel.new(frame, "Фамилия и инициалы: ")
		name_field = FXTextField.new(frame, 10)
	end
	
	def add_git_field frame
		git_label = FXLabel.new(frame, "Наличие гита: ")
		git_list = FXListBox.new(frame, width: 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		git_list.appendItem("Да")
		git_list.appendItem("Нет")
		git_list.appendItem("Не важно")
		
		git_field_label = FXLabel.new(frame, "Гит: ")
		git_field = FXTextField.new(frame, 10)
		
		git_list.connect(SEL_COMMAND) do |sender, selector, index|
			handle_list_box_command index, git_list, git_field
		end
	end
	
	def add_email_field frame
		email_label = FXLabel.new(frame, "Наличие мейла: ")
		email_list = FXListBox.new(frame, width: 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		email_list.appendItem("Да")
		email_list.appendItem("Нет")
		email_list.appendItem("Не важно")
		
		email_field_label = FXLabel.new(frame, "Мейл: ")
		email_field = FXTextField.new(frame, 30)
		
		email_list.connect(SEL_COMMAND) do |sender, selector, index|
			handle_list_box_command index, email_list, email_field
		end
	end
	
	def add_phone_field frame
		phone_label = FXLabel.new(frame, "Наличие телефона: ")
		phone_list = FXListBox.new(frame, width: 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		phone_list.appendItem("Да")
		phone_list.appendItem("Нет")
		phone_list.appendItem("Не важно")
		
		phone_field_label = FXLabel.new(frame, "Телефон: ")
		phone_field = FXTextField.new(frame, 17)
		
		phone_list.connect(SEL_COMMAND) do |sender, selector, index|
			handle_list_box_command index, phone_list, phone_field
		end
	end
	
	def add_tg_field frame
		tg_label = FXLabel.new(frame, "Наличие телеграма: ")
		tg_list = FXListBox.new(frame, width: 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		tg_list.appendItem("Да")
		tg_list.appendItem("Нет")
		tg_list.appendItem("Не важно")
		
		tg_field_label = FXLabel.new(frame, "Телеграм: ")
		tg_field = FXTextField.new(frame, 10)
		
		tg_list.connect(SEL_COMMAND) do |sender, selector, index|
			handle_list_box_command index, tg_list, tg_field
		end
	end
	
	def add_table frame
		self.table = FXTable.new(frame, :opts => LAYOUT_FILL)
		self.table.setTableSize(10, 4)
		
		self.table.setColumnText(0, "№")
		self.table.setColumnText(1, "Фамилия И. О.")
		self.table.setColumnText(2, "Контакт")
		self.table.setColumnText(3, "Гит")
		
		self.table.editable = false
		
		self.table.connect(SEL_SELECTED) do
			all_cols_selected = self.table.selEndColumn - self.table.selStartColumn + 1 == self.table.numColumns
			num_selected_rows = self.table.selEndRow - self.table.selStartRow + 1
				
			if num_selected_rows == 1 and all_cols_selected
				self.chg_button.enable
				self.del_button.enable
			elsif num_selected_rows > 1 and all_cols_selected
				self.chg_button.disable
				self.del_button.enable
			else
				self.chg_button.disable
				self.del_button.disable
			end
		end
	end
	
	def add_crud_buttons frame
		self.add_button = FXButton.new(frame, "Добавить")
		self.chg_button = FXButton.new(frame, "Изменить")
		self.del_button = FXButton.new(frame, "Удалить")
		self.upd_button = FXButton.new(frame, "Обновить")
		
		self.chg_button.disable
		self.del_button.disable
	end
	
	def add_row col_array
		table.setItem(self.row_number, 0, FXTableItem.new(col_array[0]))
		table.setItem(self.row_number, 1, FXTableItem.new(col_array[1]))
		table.setItem(self.row_number, 2, FXTableItem.new(col_array[2]))
		table.setItem(self.row_number, 3, FXTableItem.new(col_array[3]))
		
		self.row_number += 1
	end
	
	def initialize(app)
		super(app, "StudentListView" , :width => 910, :height => 450)
		self.row_number = 0
		
		# Фамилия Имя Отчество?
		hFrame1 = FXHorizontalFrame.new(self)
		self.add_name_field hFrame1
		
		# Гит
		self.add_git_field hFrame1
		
		# Мыло
		hFrame2 = FXHorizontalFrame.new(self)
		self.add_email_field hFrame2
		
		# Телефон
		hFrame3 = FXHorizontalFrame.new(self)
		self.add_phone_field hFrame3
		
		# Телеграм
		hFrame4 = FXHorizontalFrame.new(self)
		self.add_tg_field hFrame4
		
		# Табличка
		hFrame5 = FXHorizontalFrame.new(self)
		FXLabel.new(hFrame5, "Таблица")
		
		hFrame6 = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_FIX_HEIGHT)
		hFrame6.height = 230
		
		self.add_table hFrame6
		
		# Кнопочки
		hFrame7 = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X)
		add_crud_buttons hFrame7
	end
	
	def create
		super
		show(PLACEMENT_SCREEN)
	end
end
