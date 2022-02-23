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
> includes `ints`, `floats`, `strings`). You can **not** add a `list` to a set, even if it contains
> int, because the `list` is mutable. You can add a `tuple` of `ints` to a set because a `tuple` is immutable and
> an `int` is hashable.
>
> If you have a custom class you would like to add to a set, you would need to implement the `__hash__` function.
## *Iteration*

We can iterate through a set by using the built in iterator.

```python
my_set = set([1, 2, 3, 3, 5])

# This prints out 1, 2, 3, and 5 (order not guaranteed).
for elem in my_set:
    print(elem)
```

> *Note*: 
> 
> When iterating through a set, the order in which the values are given to you is
> **not deterministic**. This means that the above code could possibly print out
> `1, 2, 3, 5` or `5, 3, 1, 2`. There's no way of knowing since the user doesn't
> know how the set is storing the values internally.

## *Methods*

Be familiar with the following set functions:
- `add`: adds a new element to the set,  *O(1)* time complexity.
- `remove`: removes a specific element from the set, pass in the value. *O(1)* time complexity.
- `union`: returns the union of the two sets. *O(n)* time complexity.
- `intersection`: returns the intersection of two sets. *O(n)* time complexity.

Lists are 0-based indexed, meaning that the first element starts at index 0 instead of 1:

> *Note*: 
> 
> You can **not** index into a list because the set is unordered. The square bracket notation on a
> set will throw an error.

To check if an element is in `set`, we can use `in`.

```python
my_set = set([1, 2, 'dog'])

print(1 in my_set) # Prints True
print('cat' in my_set) # Prints False
```

Checking if an element is in a set is a *O(1)* operation.


For more information, see: [documentation](https://docs.python.org/3/tutorial/datastructures.html).