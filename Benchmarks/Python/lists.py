import timeit
import random

# We'll run the language's default sorting algorithm and a linear search algorithm on lists of different sizes
# We'll run each test 1 million times

# We'll print out the data in the following format, separated by newlines:
# {LIST SIZE} - {TEST NUMBER} - {TEST TYPE} - {TIME TAKEN}

# The test number will be 0-indexed, and will reset for each size

# The test type will be either 'SORT' or 'SEARCH'

# The list sizes we'll be using are 1 million items, 100,000 items, 10,000 items and 1,000 items
# The list items will be randomly shuffled for each trial. This time will not be taken into account

for size in (1000000, 100000, 10000, 1000):
    for test in range(1000000):
        dataset = list(range(size))
        random.shuffle(dataset)

        search_start = timeit.default_timer()
        for item in dataset:
            if item == 0:
                print(f"{size} - {test} - SEARCH - {timeit.default_timer() - search_start}")
                break

        sort_start = timeit.default_timer()
        random.sort(sort_start)
        print(f"{size} - {test} - SORT - {timeit.default_timer() - sort_start}")
