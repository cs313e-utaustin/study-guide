# Dictionaries
Python dictionaries are a collection of a **key-value** stores. In Python 3.6+, the keys of the dictionaries
are preserved in insertion order. The keys of the dictionary must be unique but the values do not have to be.
We use a dictionary when we want to associate a specific key with a value and allow for fast lookup later one
(a real life analogy would be a phonebook).
## *Basics*
You can instantiate an empty dictionary in two ways:
```python
my_dict = {}
my_dct = dict()
```

We can add to a dictionary in two ways:

```python
my_dict['bob'] = 10
my_dict.update({'alice' : 11})

# `my_dict` is now:
# { 'bob': 10, 'alice': 11 }
```

We can retrieve information from a dictionary in two ways:
```python
print(my_dict['bob']) # prints out 10.
print(my_dict.get('alice')) # prints out 11.
```
The dictionary keeps track of the last value added to the key:
```python
my_dict['bob'] = 10
my_dict['bob'] = 12

print(my_dict.get('bob')) # prints out 12.
```

Now let's take a look at an example problem to understand why dictionaries are a helfpul data structure.

## *Example Usage*

We are given an array of earnings in an array like so:
```python
earnings = [('Bob', 1), ('Alice', 2), ('Bob', 5), ('Bob', 10), ('Alice', 11) ...]
```
And now we want to find the total earnings per individual.

A solution without dictionaries might look like:

```python
alice = 0
bob = 0
for person, earning in earnings:
    if person == 'Alice':
        alice += earning
    elif person == 'Bob':
        bob += earning

print(alice)
print(bob)
```

This might be fine if our array only had values from `Bob` and `Alice`. However, what if we added new people?
We would be forced to add a new conditional for every single person (which obviously isn't a scalable solution).

Let's look at the solution now using dictionaries.

```python
earning_tracker = {}

for person, earning in earnings:
    earning_tracker[person] = earning_tracker.get(person, 0) + earning

print(earning_tracker)
```
With the dictionary, we don't need to worry about each individual person; the dictionary does the tracking and updating for us.

> *Note:*
> 
> When using `get`, the second parameter is a default value. The default value is returned if the key (first parameter) does not
> exist in the dictionary.
## *Iteration*

The default iterator for a dictionary returns the `keys`.

```python
my_dict = {'Alice': 10, 'Bob': 5}

for key in my_dict:
    print(key) # Prints the key (person name)
    print(my_dict[key]) # Prints the value (earning)
```
If we want both the key and the value, we can use the `items` function. `items` yields the key and value
as a tuple.
```python
my_dict = {'Alice': 10, 'Bob': 5}

for key, value in my_dict.items():
    print(key) # Prints the key (person name)
    print(value) # Prints the value (earning)
```

There are other ways to iterate through a dictionary (for example using the `keys` and `values` function), but the above
should be sufficient for this course.
## *Methods*

Be familiar with the following set functions:
- `update`: Updates the dictionary based on the dictionary passed in.
- `get`: Gets a specific value by the passed in key (or a default value if the key does not exist), *O(1)* time complexity.
- `pop`: Removes the key-value pair based on the key passed in, *O(1)* time complexity

To check if a key is present in a dictionary, we can use `in`:

```python
my_dict = {'Alice': 10, 'Bob': 5}

print('Alice' in my_dict) # prints True
print('John' in my_dict) # prints False
```


For more information, see: [documentation](https://docs.python.org/3/tutorial/datastructures.html).