require 'minitest/autorun'
require "student.rb"

class TestStudentMethods < Minitest::Test
	def self.get_test_student(other)
		Student.new(surname: "Точно", first_name: "Правильное", mid_name: "Имя", **other)
	end
	
	### Универсальный тест
	
	def universal_pair_test(pair_array, tested_method)
		pair_array.each do |pair|
			test_student = self.class.get_test_student(**(pair[0]))
			
			assert_equal(pair[1], test_student.method(tested_method).call)
		end
	end
	
	### Тест метода surname_initials
	
	def self.correct_name_pairs
		[
			[{surname: "Курбатский", first_name: "Владимир", mid_name: "Александрович"}, "Курбатский В.А."],
			[{surname: "Якухнов", first_name: "Роман", mid_name: "Андреевич"}, "Якухнов Р.А."],
			[{surname: "Мищенко", first_name: "Александр", mid_name: "Николаевич"}, "Мищенко А.Н."],
			[{surname: "Фамилия", first_name: "Имя", mid_name: "Отчество"}, "Фамилия И.О."],
			[{surname: "Другаяфамилия", first_name: "Имя", mid_name: "Отчество"}, "Другаяфамилия И.О."]
		]
	end
	
	def test_surname_initials
		universal_pair_test(self.class.correct_name_pairs, :surname_initials)
	end
	
	### Тест метода contact
	
	def self.correct_contact_pairs
		[
			[{phone: "79255508819"}, "79255508819"],
			[{telegram: "@wintttr"}, "@wintttr"],
			[{email: "hr6zdl@yandex.ru"}, "hr6zdl@yandex.ru"]
		]
	end
	
	def test_contact
		universal_pair_test(self.class.correct_contact_pairs, :contact)
	end
	
	### Тест метода get_info
	
	def self.correct_info_pairs
		[
			[
				{surname: "Курбатский", first_name: "Владимир", mid_name: "Александрович", git: "SeemerGG", phone: "+79181234567"},
				"surname_initials:{Курбатский В.А.},git:{SeemerGG},contact:{79181234567}"
			],
			[
				{surname: "Мищенко", first_name: "Александр", mid_name: "Николаевич", id: 1, git: "niznayu", telegram: "@tozhe_niznayu"},
				"surname_initials:{Мищенко А.Н.},git:{niznayu},contact:{@tozhe_niznayu}"
			],
			[
				{surname: "Якухнов", first_name:"Роман", mid_name: "Андреевич", telegram: "@redmag", git: "redmag"},
				"surname_initials:{Якухнов Р.А.},git:{redmag},contact:{@redmag}"
			]
		]
	end
	
	def test_get_info
		universal_pair_test(self.class.correct_info_pairs, :get_info)
	end
end