# Binary Search

Binary Search is one of the most important algorithsm in computer science. Given a sorted search space, we
can find our desired element in *O(log n)* time.

## *Sample Implementation*

```python

def binary_search(array: List[int], find: int) -> bool:
    """
        Searches on `array` for the specified element `find`.
        Requires that `array` be sorted beforehand.

        Returns True if found, False otherwise.
    """

    # Initializing our pointers to the start and end of the array.
    low = 0
    high = len(array) - 1

    while low <= high:

        mid = low + (high - low) // 2

        # Found our element, return.
        if array[mid] == x:
            return True

        # Construct search space since we know
        # the list is sorted.
        if array[mid] < x:
            low = mid + 1
        else:
            high = mid - 1

        return False

```
> *Note*:
>
> There's a famous [overflow bug](https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html) in the original binary 
> search implementation with `(high + low) // 2`. This isn't as big of an issue in Python as it is in C or C++, but it is now generally
> accepted that the correct calculation for mid is `low + (high - low) // 2`.