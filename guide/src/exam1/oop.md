# Object-Oriented Programming

Object-oriented programming is a programming paradigm that organizes software around data (objects), instead of functions and logic. You will have have 1 mandatory OOP problem on exam 1, where we will give you the specification for a class for you to implement.

For more information, visit: [OOP lecture notes](https://www.cs.utexas.edu/users/mitra/csSpring2023/cs313/lectures/oop.html).

## Objects

An object is a concept, an abstraction, a thing with sharp boundaries and meaning for an application. It has:

- Identity - a name
- State - determined by the values of its attributes
- Behavior - determined by how the object acts or reacts to requests (messages) from other objects

## Classes

A class is a description of a group of objects with common properties (attributes), behavior (operations), relationships, and semantics. An object is an instance of a class.

Classes are an abstraction - given an interface for the class, you do not need to know the implementation details to be able to perform operations on objects of the class.

## Operations (Functions)

An operation is a service that can be requested from any object of the class to affect behavior.

An operation can request information from the object's state or update the object's state. The outcome of the operation depends on the current state of the object.

## Example

```python
class CookieJar(object):

  # Constructor that accepts 1 integer as a parameter, the number
  # of cookies initially in the jar. This value defaults to 0
  def __init__(self, cookies = 0):
    self.num_cookies = cookies

  # Add a cookie to the jar.
  def add_cookie(self):
    self.num_cookies += 1

  # If there are any cookies left, take a cookie from the jar.
  def take_cookie(self):
    if self.num_cookies >= 1:
      self.num_cookies -= 1
      return "Took a cookie from the cookie jar!"
    return "The cookie jar is empty :("

  # String representation of the cookie jar that describes how many cookies are left.
  def __str__(self):
    return f"There are {self.num_cookies} cookies in the cookie jar."

  # Two cookie jars are equal if they have the same number of cookies.
  def __eq__(self, other):
    return self.num_cookies == other.num_cookies

```

The `self` keyword is used to reference the current instance of the class.
`add_cookie` and `take_cookie` are operations that update the state of an object, while `__str__` and `__eq__` return information about the state of the object.

Now, here is an example of how the class can be used:

```python
def main():
  jar1 = CookieJar()
  print(jar1)           # There are 0 cookies in the cookie jar.

  jar2 = CookieJar(2)
  print(jar2)           # There are 2 cookies in the cookie jar.
  print(jar1 == jar2)   # False

  jar1.add_cookie()
  print(jar1)           # There are 1 cookies in the cookie jar.

  jar2.take_cookie()
  print(jar1 == jar2)   # True

  print(jar1.take_cookie()) # Took a cookie from the cookie jar!
  print(jar1)           # There are 0 cookies in the cookie jar.

  print(jar1.take_cookie()) # The cookie jar is empty :(
  print(jar1)           # There are 0 cookies in the cookie jar.

```

> _Note_:
>
> The only piece of state here is the `num_cookies` attribute of the class.
> However, to use this class (as shown in `main()`), there is no need to have any knowledge about it.
>
> The attribute could have been named `cookies`, `cookies_count`, `n`, etc; it could have been stored as a float, or a string, or whatever we liked. None of these implementation
> details would have affected any of the code in `main()`, as long as the inputs
> and outputs of each method of the class is consistent with the specifications.
