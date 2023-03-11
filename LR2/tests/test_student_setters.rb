require 'minitest/autorun'
require "student.rb"

class TestStudentSetters < Minitest::Test
	def self.get_test_student
		Student.new surname: "Точно", first_name: "Правильное", mid_name: "Имя"
	end
	
	### Универсальный тест сеттера
	
	def setter_test field, correct_array, incorrect_array
		test_student = self.class.get_test_student
		
		correct_array.each do |name|
			begin
				test_student.method(:"#{field}=").call name
			rescue 
				assert false, "Error with value #{name}"
			end
			
			assert true
		end
		
		incorrect_array.each do |name|
			assert_raises (ArgumentError) do
				test_student.method(:"#{field}=").call name
			end
		end
	end

	### Тест сеттеров имени
	
	def self.correct_names
		[ "Владимир", "Роман", "Александр", "Любойнаборсимволов" ]
	end
	
	def self.incorrect_names
		[ "Влад1мир", "Р_о_м_а_н", "!Ал!ександр", "Любой набор символов" ]
	end
	
	def test_surname_setter
		setter_test :surname, self.class.correct_names, self.class.incorrect_names
	end
	
	def test_first_name_setter
		setter_test :first_name, self.class.correct_names, self.class.incorrect_names
	end
	
	def test_mid_name_setter
		setter_test :mid_name, self.class.correct_names, self.class.incorrect_names
	end
	
	### Тест на capitalize
	
	def self.correct_name_pairs
		[
			["вЛаДиМир", "Владимир"],
			["роман", "Роман"],
			["александР", "Александр"]
		]
	end
	
	def test_name_setter_capitalize
		test_student = self.class.get_test_student
		
		self.class.correct_name_pairs.each do |pair|
			test_student.surname = pair[0]
			test_student.first_name = pair[0]
			test_student.mid_name = pair[0]
			
			assert_equal pair[1], test_student.surname
			assert_equal pair[1], test_student.first_name
			assert_equal pair[1], test_student.mid_name
		end
	end
	
	### Тест сеттера гита
	
	def self.correct_gits
		[ "SeemerGG", "Seemer-GG", "wintttr", "RedMaG01" ]
	end
	
	def self.incorrect_gits
		[ "-SeemerGG-", "Red--MaG01", "win   tttr", "аяпользуюськириллицей"]
	end
	
	def test_git_setter
		setter_test :git, self.class.correct_gits, self.class.incorrect_gits
	end
	
	### Тест сеттера телефона
	
	def self.correct_phones
		[ 	
			"+79255508819",
			"+7(925)550-88-19",
			"8(925)5508819",
			"+7 (925) 550-88-19",
			"79255508819"
		]
	end
	
	def self.incorrect_phones
		[
			"+ 79255508819",
			"+7925550889",
			"+9255508819",
			"+7(9255508819",
			"+7925)5508829",
			"+79255508819a",
			"123"
		]
	end
	
	def test_phone_setter
		setter_test :phone, self.class.correct_phones, self.class.incorrect_phones
	end
	
	### Доп. тест сеттера телефона
	
	def self.correct_phone_pairs
		[ 	
			["+79255508819", "79255508819"],
			["+7(925)550-88-19", "79255508819"],
			["8(925)5508819", "79255508819"],
			["+7 (925) 550-88-19", "79255508819"],
			["79255508819", "79255508819"]
		]
	end
	
	def test_phone_setter_modification
		test_student = self.class.get_test_student
		
		self.class.correct_phone_pairs.each do |pair|
			test_student.phone = pair[0]
			
			assert_equal pair[1], test_student.phone
		end
	end
	
	
	### Тест сеттера мейла
	
	def self.correct_emails
		[
			"o@outlook.com",
			"hr6zdl@yandex.ru",
			"kaft93x@outlook.com",
			"dcu@yandex.ru"
		]
	end
	
	def self.incorrect_emails
		[
			"123",
			"abcdef",
			"+79255508819",
			"+7(925)550-88-19"
		]
	end
	
	def test_email_setter
		setter_test :email, self.class.correct_emails, self.class.incorrect_emails
	end
	
	# Тест сеттера телеграма
	
	def self.correct_tgs
		[
			"@abcdef",
			"@ABCDEFF",
			"@RedMaG01"
		]
	end
	
	def self.incorrect_tgs
		[
			"123",
			"abcdef",
			"+79255508819",
			"+7(925)550-88-19",
			"vladimir",
			"@VOVA"
		]
	end
	
	def test_telegram_setter
		setter_test :telegram, self.class.correct_tgs, self.class.incorrect_tgs
	end
	
	# Тест сеттера id
	
	def self.correct_ids
		r = Random.new
		(0..500).map {|_| r.rand(100000)}
	end
	
	def self.incorrect_ids
		r = Random.new
		(0..500).map {|_| (r.rand(100000).to_s + (65 + rand(26)).chr)}
	end
	
	def test_id_setter
		setter_test :id, self.class.correct_ids, self.class.incorrect_ids
	end
end