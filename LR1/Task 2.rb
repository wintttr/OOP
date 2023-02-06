# Предикат проверяющий числа на взаимную простоту
def coprime?(x, y)
    x.gcd(y) == 1
end

# Находим количество чисел, взаимнопростых с данным
def coprime_count(x)
    count = 0

    for i in (2...x)
        if coprime? x, i then 
            count += 1 
        end
    end

    count
end

# Находим сумму значений функции func от каждой цифры
# числа x, удовлетворяющей предикату pred 
def num_proc(x, pred, func)
    acc = 0
    while x > 0 do
        if pred.call x % 10 then
            acc += func.call x % 10
        end
        x = x / 10
    end
    acc
end

# СПРОСИТЬ ПРО ЭТО
# Находим сумму цифр числа x, удовлетворяющих предикату pred 
def num_sum(x, pred)
    num_proc x, pred, lambda { |x| x }
end

def num_div_by_3_sum(x)
    # И ПРО ЭТО
    num_sum x, lambda {|y| y % 3 == 0}
end

# Находим количество цифр числа x, удовлетворяющих предикату pred
def num_count(x, pred)
    num_proc x, pred, lambda {|_| 1}
end

# Находим количество цифр числа x, взаимнопростых с y 
def num_coprime_with_y_count(x, y)
    num_count x, lambda {|t| coprime? t, y}
end

# Находим все делители числа x
def all_divs(x)
    arr = Array.new
    for i in (2..x)
        if x % i == 0 then
            arr.push i
        end
    end

    arr
end

# Находим делитель числа, являющийся взаимно простым с
# наибольшим количеством цифр данного числа.
def find_max_div(x)
    divs = all_divs x
    count_array = Array.new 
    
    divs.each { |i|
        count_array.push num_coprime_with_y_count x, i
    }

    divs[count_array.index count_array.max]
end