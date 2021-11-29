import timeit

# We'll run the language's default sorting algorithm and a linear search algorithm on lists of different sizes
# We'll run each test 5 times, we'll run each algorithm 1000 times per test

# We'll use timeit to output our results

# The list sizes we'll be using are 1 million items, 100,000 items, 10,000 items and 1,000 items
# The list items will be randomly shuffled for each trial. This time will not be taken into account

define = """
import random

def create_dataset(length):
    dataset = list(range(length))
    random.shuffle(dataset)
    return dataset
    
def search(dataset):
    for index, item in enumerate(dataset):
        if item == 0:
            return index

def sort(dataset):
    return sorted(dataset)
"""

for operation in ("sort", "search"):
    for size in (1000000, 100000, 10000, 1000):
        print(f"Time to {operation} {size} items")
        result = timeit.repeat(
            setup = f"{define}\ndataset = create_dataset({size})",
            stmt = f"{operation}(dataset)",
            number = 1000,
            repeat = 5,
        )
        print(result)

