# Sets
Python sets are **mutable**, **unordered** sequence of elements that are **unique** and **iterable**. We use sets when
we are interested in guaranteeing the uniquess of elements.
## *Basics*
You can instantiate an empty set like so:
```python
my_set = set()
```

If you would like to initialize a set with specific values:

```python
values = [1, 2, 3, 4]
my_set = set(values)
```

If you pass in a list with duplicate values to the constructor, the set will ignore them.
```python
values = [1, 1, 1, 1]
my_set = set(values) # `my_set` here only contains a single element: 1
```
2-dimensional lists are lists of lists. We often use this to represent a matrix or a grid.
Here are some ways to instantiate 2-d lists.
> *Note*: 
> 
> Sets guarantee efficient uniqueness by [hashing](https://en.wikipedia.org/wiki/Hash_function) elements that
> are added to it. This means you can only add elements to the set that are hashable (by default in Python, this
> includes `ints`, `floats`, `strings`, and `tuples`). You can **not** add a `list` to a set because the `list` is mutable.
>
> If you have a custom class you would like to add to a set, you would need to implement the `__hash__` function.
## *Iteration*
We can iterate through a list in multiple ways (as you know from working on `WordSearch`).

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