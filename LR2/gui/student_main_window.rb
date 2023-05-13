require 'fox16'
include Fox 

class StudentMainWindow < FXMainWindow
	attr_reader :add_button, :chg_button, :del_button, :upd_button
	attr_reader :go_left_button, :go_right_button
	attr_reader :page_count_label, :cur_page_label
	attr_reader :table, :tabBook
	
	def initialize(app)
		super(app, "StudentListView" , :width => 650, :height => 500)
		
		self.tabBook = FXTabBook.new(self)
		tabFrame1 = FXTabItem.new(self.tabBook, "Вкладка 1", nil)
		vFrame1 = FXVerticalFrame.new(self.tabBook)
		
		tabFrame2 = FXTabItem.new(self.tabBook, "Вкладка 2", nil)
		vFrame2 = FXVerticalFrame.new(self.tabBook)
		
		tabFrame3 = FXTabItem.new(self.tabBook, "Вкладка 3", nil)
		vFrame3 = FXVerticalFrame.new(self.tabBook)
		
		# Фамилия Имя Отчество?
		hFrame1 = FXHorizontalFrame.new(vFrame1)
		self.add_name_field(hFrame1)
		
		# Гит
		self.add_git_field(hFrame1)
		
		# Мыло
		hFrame2 = FXHorizontalFrame.new(vFrame1)
		self.add_email_field(hFrame2)
		
		# Телефон
		hFrame3 = FXHorizontalFrame.new(vFrame1)
		self.add_phone_field(hFrame3)
		
		# Телеграм
		hFrame4 = FXHorizontalFrame.new(vFrame1)
		self.add_tg_field(hFrame4)
		
		# Табличка
		hFrame5 = FXHorizontalFrame.new(vFrame1)
		FXLabel.new(hFrame5, "Таблица")
		
		hFrame6 = FXHorizontalFrame.new(vFrame1, opts: LAYOUT_FILL_X | LAYOUT_FIX_HEIGHT)
		hFrame6.height = 230
		
		self.add_table(hFrame6)
		
		# Перелистываем страницы
		hFrame7 = FXHorizontalFrame.new(vFrame1, opts: LAYOUT_FILL_X)
		add_lcr_buttons(hFrame7)
		
		# Кнопочки
		hFrame8 = FXHorizontalFrame.new(vFrame1, opts: LAYOUT_FILL_X)
		add_crud_buttons(hFrame8)
	end
	
	def create
		super
		show(PLACEMENT_SCREEN)
	end
	
	def set_table_headers(arr)
		self.table.setColumnText(0, "№")
		
		arr.each_with_index { |value, index|
			self.table.setColumnText(index+1, value)
		}
	end
	
	private
	attr_writer :add_button, :chg_button, :del_button, :upd_button
	attr_writer :go_left_button, :go_right_button
	attr_writer :page_count_label, :cur_page_label
	attr_writer :table, :tabBook
	
	
	def handle_list_box_command(index, listbox, field)
		item_text = listbox.getItemText(index)
		if(item_text == "Да")
			field.enable
		else
			field.disable
		end
	end
	
	def add_listboxed_field(frame, presence_of, field_name, field_width)
		label = FXLabel.new(frame, presence_of)
		list = FXListBox.new(frame, width: 10, opts: COMBOBOX_STATIC | COMBOBOX_NO_REPLACE)
		list.appendItem("Да")
		list.appendItem("Нет")
		list.appendItem("Не важно")
		
		field_label = FXLabel.new(frame, "Гит: ")
		field = FXTextField.new(frame, field_width)
		
		list.connect(SEL_COMMAND) do |_, _, index|
			handle_list_box_command(index, list, field)
		end
	end
	
	def add_name_field(frame)
		name_label = FXLabel.new(frame, "Фамилия и инициалы: ")
		name_field = FXTextField.new(frame, 10)
	end
	
	def add_git_field(frame)
		add_listboxed_field(frame, "Наличие гита: ", "Гит: ", 10)
	end
	
	def add_email_field(frame)
		add_listboxed_field(frame, "Наличие мейла: ", "Мейл: ", 30)
	end
	
	def add_phone_field(frame)
		add_listboxed_field(frame, "Наличие телефона: ", "Телефон: ", 17)
	end
	
	def add_tg_field(frame)
		add_listboxed_field(frame, "Наличие телеграма: ", "Телеграм: ", 10)
	end
	
	def add_table(frame)
		self.table = FXTable.new(frame, :opts => LAYOUT_FILL)
		self.table.editable = false
	end
	
	def add_crud_buttons(frame)
		self.add_button = FXButton.new(frame, "Добавить")
		self.chg_button = FXButton.new(frame, "Изменить")
		self.del_button = FXButton.new(frame, "Удалить")
		self.upd_button = FXButton.new(frame, "Обновить")
		
		self.chg_button.disable
		self.del_button.disable
	end
	
	def add_lcr_buttons(frame)
		self.go_left_button = FXButton.new(frame, "<<")
		
		self.cur_page_label = FXLabel.new(frame, "")
		
		FXLabel.new(frame, "/")
		
		self.page_count_label = FXLabel.new(frame, "")
		
		self.go_right_button = FXButton.new(frame, ">>")
	end
end
