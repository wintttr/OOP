require "student.rb"
require "student_short.rb"
require "students_list.rb"
require "txt_reader_writer.rb"
require "json_reader_writer.rb"

a = Student.new id: 10, surname: "Курбатский", first_name: "Владимир", mid_name: "Александрович", git: "SeemerGG", phone: "+79181234567"
b = Student.new surname: "Мищенко", first_name: "Александр", mid_name: "Николаевич", id: 1
c = Student.new surname: "Якухнов", first_name:"Роман", mid_name: "Андреевич", telegram: "@redmag"

sl = StudentsList.new
sl.add_obj a
sl.add_obj b
sl.add_obj c

sl.write_all_objects(JSONReaderWriter.new "json_for_test.json")