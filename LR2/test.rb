require_relative "student"

def test test_array, field, test_name = ["Фамилия", "Имя", "Отчество"]
    for el in test_array do
        correct = true
    begin
        Student.new surname: test_name[0], first_name: test_name[1], mid_name: test_name[2], field => el[0]
    rescue ArgumentError
        correct = false
    rescue Exception
        raise Exception, "аааааааааааааааааааааа, что дееееееелаааааааааааааааааааааать такой ошибки я не предусмотрел!"
    end
        if correct == el[1]
            puts "Тест пройден успешно, строка \"#{el[0]}\" - #{correct ? "корректна" : "некорректна"}."
        else
            puts "Тест не пройден, строка: \"#{el[0]}\""
        end
    end
end


numbers = [
    ["+79255508819", true],
    ["+7(925)550-88-19", true],
    ["8(925)5508819", true],
    ["+7 (925) 550-88-19", true],
    ["+ 79255508819", false],
    ["+7925550889", false],
    ["+9255508819", false],
    ["+7(9255508819", false],
    ["+7925)5508829", false],
    ["+79255508819a", false],
    ["123", false],
]

telegrams = [
    ["@abcdef", true],
    ["@ABCDEFF", true],
    ["@123", false],
    ["abcdef", false],
    ["@фвафва", false]
]

emails = [
	["o@outlook.com", true],
	["hr6zdl@yandex.ru", true],
	["kaft93x@outlook.com", true],
	["dcu@yandex.ru", true],
	["19dn@outlook.com", true],
	["pa5h@mail.ru", true],
	["281av0@gmail.com", true],
	["8edmfh@outlook.com", true],
	["sfn13i@mail.ru", true],
	["g0orc3x1@outlook.com", true],
	["123", false],
	["abcdef", false]
]

puts "Тест номера телефона"
test numbers, :phone
puts

puts "Тест телеграм ника"
test telegrams, :telegram
puts

puts "Тест имейла"
test emails, :email
puts