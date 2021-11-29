import timeit

# We'll run the language's default sorting algorithm and a linear search algorithm on lists of different sizes
# We'll run each test 1 million times

# We'll print out the data in the following format, separated by newlines:
# {LIST SIZE} - {TEST NUMBER} - {TIME TAKEN}

# The list sizes we'll be using are 1 million items, 100,000 items, 10,000 items and 1,000 items
# The list items will be randomly shuffled for each trial. This time will not be taken into account

for size in (1000000, 100000, 10000, 1000):
    
