require 'minitest/autorun'
require "data_list_student_short.rb"
require "student_short.rb"
require "student.rb"


class TestDataListSS < Minitest::Test
	def self.get_students_shorts
		a = {:surname => "Курбатский", :first_name => "Владимир", :mid_name => "Александрович", :git => "SeemerGG", :phone => "+79181234567"}
		b = {:surname => "Мищенко", :first_name => "Александр", :mid_name => "Николаевич", :id => 1, :git => "niznayu", :telegram => "@tozhe_niznayu"}
		c = {:surname => "Якухнов", :first_name => "Роман", :mid_name => "Андреевич", :telegram => "@redmag", :git => "redmag"}
		
		a = StudentShort.student_ctor(Student.new(**a))
		b = StudentShort.student_ctor(Student.new(**b))
		c = StudentShort.student_ctor(Student.new(**c))
		
		[a, b, c]
	end

	def test_initialize
		ss = self.class.get_students_shorts
		
		(DataListStudentShort.new ss).get_data
	end
end