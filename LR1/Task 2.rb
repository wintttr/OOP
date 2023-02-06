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
# Находим сумму цифр числа x, если pred(цифра) == true 
def num_sum(x, pred)
    num_proc x, pred, lambda { |_| 1 }
end

def num_div_by_3_sum(x)
    # И ПРО ЭТО
    num_sum x, lambda {|y| y % 3 == 0}
end