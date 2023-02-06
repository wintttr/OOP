# Если пользователь передал больше/меньше 1 аргумента, выводим ошибку
if ARGV.size != 1 then 
    STDERR.puts "ERROR ERROR ERROR!!!!!!"
    exit
end

puts "Привет, #{ARGV[0].capitalize}!"
puts "Какой твой любимый язык программирования?"

# Читаем стандартный ввод, удаляем символ переноса строки
# в конце и переводим строку в нижний регистр
favourite_language = STDIN.gets.chomp.downcase

case favourite_language
when "ruby"
    puts "Подлиза"
when "c++"
    puts "Хорош!"
when "文言"
    puts "+15 социальный рейтинг, партия выдать миска рис и кошачья жена, удар!"
else 
    puts "... Ладно"
end