# Lists
Python lists are **mutable** and **ordered** sequence of elements. We use lists when we
want to track multiple elements at once and want to preserve their ordering.
## *Basics*
You can instantiate an empty list in two ways:
```python
lst = []
lst = list()
```

If you would like to initialize a list with a predetermined size and starting values:

```python
default = 0
size = 5

lst = [default for _ in range(size)]
lst = [default] * size
```

2-dimensional lists are lists of lists. We often use this to represent a matrix or a grid.
Here are some ways to instantiate 2-d lists.

```python
# Corresponds to how many lists there are.
rows = 3

# Corresponds to how many elements are in the inner list.
columns = 2

default = 0

matrix = [[default for _ in range(columns)] for _ in range(rows)] 
matrix = [[default] * columns for _ in range(rows)]
```
> *Note*: 
> ```python
> matrix = [[default] * columns] * rows
> ```
> The above code will not work due to reference issues. The same list
> will be duplicated across all rows.
## *Iteration*
We can iterate through a 1d list like so:
```python
my_list = [1, 2, 3, 4]

for i in range(len(my_list)):
    print(my_list[i])
```

We can iterate through a 2d list in multiple ways (as you know from working on `WordSearch`).

<p align="center" width="100%">
    <img
        src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Row_and_column_major_order.svg/1200px-Row_and_column_major_order.svg.png"
        alt="row-column-traversal"
        width="250px"
    />
</p>

1. Row-order traversal

    ```python
    for row in range(len(matrix)):
        for col in range(len(matrix[row])):
            # Prints out each element in the matrix.
            print(matrix[row][col])
    ```
2. Column-order traversal

    ```python
    for col in range(len(matrix[0])):
        for row in range(len(matrix)):
            # Prints out each element in the matrix.
            print(matrix[row][col])
    ```
<br/>

If you don't care about the index when iterating, you can also use the built-in iterator for lists to go through every element.
```python
for row in matrix:
    for element in row:
        # Prints each element in matrix
        print(element)
```

## *Methods*

Be familiar with the following list functions:
- `append`: adds a new element to the end of the list
- `pop`: removes element at the given index
- `insert`: inserts an element to the list at the given index
- `sort`: sorts the list, can provide a custom lambda for the key
- `extend`: adds iterable elemnts to the end of the list

Lists are 0-based indexed, meaning that the first element starts at index 0 instead of 1:

```python
>>> my_list = [1, 2, 3, 4, 5]
[1, 2, 3, 4, 5]

>>> my_list[0]
1
```

To get the elements near the back of the list, we can use negative indices: -1 corresponds to the last
element, -2 the second to last, etc...

```python
>>> my_list[-1]
5
```

We can slice a list by using the following syntax:
```python
>>> my_list[0:2]
[1, 2]
```

Notice that the ending index is **exclusive** (this is very similar to the range function).


For more information, see: [documentation](https://docs.python.org/3/tutorial/datastructures.html).