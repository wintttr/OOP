require_relative "student"
require_relative "student_short"

a = Student.new surname: "Курбатский", first_name: "Владимир", mid_name: "Александрович", git: "SeemerGG", phone: "+79181234567"
b = Student.new surname: "Мищенко", first_name: "Александр", mid_name: "Николаевич", id: 1
c = Student.new surname: "Якухнов", first_name:"Роман", mid_name: "Андреевич", telegram: "@redmag"

puts a, $/
puts b, $/
puts c, $/

puts

puts a.inspect
puts b.inspect
puts c.inspect

puts

puts (Student.string_ctor a.inspect), $/
puts (Student.string_ctor b.inspect), $/
puts (Student.string_ctor c.inspect), $/

puts

puts a.get_info

puts 

s_short = StudentShort.student_ctor a

puts (s_short), $/
puts s_short.inspect, $/
puts (StudentShort.string_ctor s_short.inspect), $/
