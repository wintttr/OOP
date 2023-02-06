puts "Введите команду языка Ruby"
ruby_cmd = STDIN.gets
eval ruby_cmd

puts "Введите команду OS"
os_cmp = STDIN.gets
system os_cmp