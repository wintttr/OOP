def minimal_element_index(array)
    array.index array.min
end

def count_in_interval(array, a, b)
    array.count {|i| i >= a && i <= b}
end

