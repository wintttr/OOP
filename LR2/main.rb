require_relative "student"

a = Student.new surname: "Курбатский", first_name: "Владимир", mid_name: "Александрович", git: "SeemerGG", phone: "+79181234567"
b = Student.new surname: "Мищенко", first_name: "Александр", mid_name: "Николаевич", id: 1
c = Student.new surname: "Якухнов", first_name:"Роман", mid_name: "Андреевич", telegram: "@redmag"


puts a, $/
puts b, $/
puts c, $/