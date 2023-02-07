def minimal_element_index(array)
    array.index array.min
end

def count_in_interval(array, a, b)
    array.count {|i| i >= a && i <= b}
end

def count_between_min(array)
    min1 = array.index array.min
    array.delete_at min1
    min2 = array.index array.min

    min2 - min1 + 1
end
