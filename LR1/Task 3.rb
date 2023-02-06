def minimal(array)
    min = array[0]

    for element in array do
        if element < min then
            min = element
        end
    end

    min
end

def maximal(array)
    max = array[0]

    for element in array do
        if element > max then
            max = element
        end
    end

    max
end

def first_positive_element(array)
    for index in (0...array.size) do
        if array[index] > 0
            return index
        end
    end
end

def main()
    if ARGV.size != 2 then
        STDERR.puts "ERROR ERROR ERROR!!!!"
        exit
    end

    array = (File.readlines ARGV[1]).map{ |str| str.to_i }

    case ARGV[0].to_i
    when 1
        puts "Минимальный элемент массива: #{minimal(array)}"
    when 2
        puts "Максимальный элемент массива: #{maximal(array)}"
    when 3
        puts "Индекс первого положительного элемента массива: #{first_positive_element(array)}"
    else
        puts "Нет такой функции..."
    end
end

main