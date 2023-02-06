# Предикат проверяющий числа на взаимную простоту
def coprime?(x, y)
    x.gcd(y) == 1
end

# Находим количество чисел, взаимнопростых с данным
def coprime_count(x)
    count = 0
    
    for i in (2...x)
        if coprime?(x, i) then 
            count += 1 
        end
    end

    count
end

