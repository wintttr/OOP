require_relative "student"

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

for phone in numbers do
    correct = true
begin
    Student.new surname: "Фамилия", first_name: "Имя", mid_name: "Отчество", phone: phone[0]
rescue ArgumentError
    correct = false
rescue Exception
    raise Exception, "аааааааааааааааааааааа, что дееееееелаааааааааааааааааааааать такой ошибки я не предусмотрел!"
end
    if correct == phone[1]
        puts "Тест пройден успешно, номер \"#{phone[0]}\" - #{correct ? "правильный" : "неправильный"}."
    else
        puts "Номер \"#{phone[0]}\" неправильный, тест не пройден."
    end
end