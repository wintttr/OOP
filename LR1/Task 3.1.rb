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

