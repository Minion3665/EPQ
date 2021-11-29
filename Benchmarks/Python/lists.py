import timeit

# We'll run the language's default sorting algorithm and a linear search algorithm on lists of different sizes
# We'll run each test 5 times, we'll run each algorithm 1000 times per test

# We'll use timeit to output our results

# The list sizes we'll be using are 10^1-6
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
    for size in range(1, 7):
        total_size = 10 ** size
        print(f"Time to {operation} {total_size} items")
        result = timeit.repeat(
            setup = f"{define}\ndataset = create_dataset({total_size})",
            stmt = f"{operation}(dataset)",
            number = 1000,
            repeat = 5,
        )
        print(f"{result}\n")

