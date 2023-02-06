# Предикат проверяющий числа на взаимную простоту
def coprime?(x, y)
    x.gcd(y) == 1
end

# Находим количество чисел, взаимнопростых с данным
def coprime_count(x)
    (1..x).select{|i| coprime? x, i }.size
end

# Находим сумму значений функции func от каждой цифры
# числа x, удовлетворяющей предикату pred 
def num_proc(x, pred, func)
    x.digits.select {|i| pred.call i}
            .map {|i| func.call i}
            .sum
end

# СПРОСИТЬ ПРО ЭТО (можно ли сделать ограничение на передачу ТОЛЬКО предиката)
# Находим сумму цифр числа x, удовлетворяющих предикату pred 
def num_sum(x, pred)
    num_proc x, pred, lambda { |x| x }
end

def num_div_by_3_sum(x)
    # И ПРО ЭТО (можно ли сделать это как-то лучше)
    num_sum x, lambda {|y| y % 3 == 0}
end

# Находим количество цифр числа x, удовлетворяющих предикату pred
def num_count(x, pred)
    num_proc x, pred, lambda {|_| 1}
end

# Находим количество цифр числа x, взаимнопростых с y 
def num_coprime_with_y_count(x, y)
    # И ПРО ЭТО (можно ли это сделать без лямбды)
    num_count x, lambda {|t| coprime? t, y}
end

# Находим все делители числа x
def all_divs(x)
    array_of_divs = (2..x).select {|i| x % i == 0}
end

# Находим делитель числа, являющийся взаимно простым с
# наибольшим количеством цифр данного числа.
def find_max_div(x)
    divs = all_divs x

    count_array = divs.map { |i| num_coprime_with_y_count x, i }

    divs[count_array.index count_array.max]
end