# Задание 2
def minimal_element_index(array)
    array.index array.min
end

# Задание 14 
def elements_in_interval(array, a, b)
    if b > array.size then
        b = array.size
    end

    if a < 0 then
        a = 0
    end

    b - a + 1
end

# Задание 26
def count_between_min(array)
    min1 = array.index array.min
    
    array.delete_at min1
    min2 = array.index array.min

    min2 - min1 + 1
end

# Задание 38 - то же самое, что и задание 14
def count_in_interval(array, a, b)
    array.count {|i| i >= a && i <= b}
end

# Задание 50
# Не знаю, как это сделать по человечески...
def elements_only_in_one_arr(l1, l2)
    part1 = l1.reject { |el| l2.include? el }
    part2 = l2.reject { |el| l1.include? el }

    (part1 + part2).sort.uniq
end

puts elements_only_in_one_arr [1,2,3,4], [3,4,5,6]