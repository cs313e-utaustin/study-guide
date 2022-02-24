# Sorts

Sorting algorithms rearrange a list of elements based on a comparator. There exists a variety of sorting algorithms, some popular
ones include:

- Selection Sort
- Insertion Sort
- Quick Sort
- Merge Sort
- Counting Sort
- Radix Sort

Here's a [cool video](https://www.youtube.com/watch?v=kPRA0W1kECg) visualizing the different kinds of sorting algorithms.

For the exam, you should be familiar with Selection Sort, Insertion Sort, and the merging step of Merge Sort.

## *Selection Sort*

**Main Idea**: Select the smallest element on each iteration and place it towards the beginning.

**Sample Implementation**:
```python

def selection_sort(array: List[int]) -> None:
    """
        Sorts the `array` in place in ascending order.
    """

    size = len(array)

    for pointer_one in range(size):

        min_idx = pointer_one

        for pointer_two in range(pointer_one + 1, size):
            
            # Found something that is smaller, update `min_idx`.
            if array[min_idx] < array[pointer_two]:
                min_idx = pointer_two
        
        # Put minimum element in correct place.
        array[pointer_one], array[min_idx] = array[min_idx], array[pointer_one]

```
[Source](https://www.programiz.com/dsa/selection-sort)

**Time Complexity**: O(n<sup>2</sup>)

## *Insertion Sort*

**Main Idea**: On each iteration, expand the sorted block by placing an unsorted element in its appropriate place.

**Sample Implementation**:
```python

def insertion_sort(array: List[int]) -> None:
    """
        Sorts `array` in ascending order in place.
    """

    for step in range(1, len(array)):
        key = array[step]
        j = step - 1
        
        # Compare key with each element on the left of it until an element smaller than it is found
        # For descending order, change key<array[j] to key>array[j].        
        while j >= 0 and key < array[j]:
            array[j + 1] = array[j]
            j = j - 1
        
        # Place key at after the element just smaller than it.
        array[j + 1] = key

```
[Source](https://www.programiz.com/dsa/insertion-sort)

**Time Complexity**: O(n<sup>2</sup>)

## *Merge Sort*

**Main Idea**: Split list in half, sort on those halves and merge.

**Sample Implementation (Merging Step)**:
```python

def merge_halves(half_one: List[int], half_two: List[int]) -> List[int]:
    """
        Merges two halves of a list (in ascending order). Returns
        a new list.
    """

    h_one_idx = 0
    h_two_idx = 0
    ret = []

    # Iterate until we reach the end of one of the lists
    while h_one_idx < len(half_one) and h_two_idx < len(half_two):
        elem_one = half_one[h_one_idx]
        elem_two = half_two[h_two_idx]

        # Case 1: element one is smaller,
        # add it to the list and advance
        # the pointer for list one.
        if elem_one < elem_two:
            ret.append(elem_one)
            h_one_idx += 1
        # Case 2: element two is smaller,
        # do the same for list two.
        else:
            ret.append(elem_two)
            h_two_idx += 1

    # In case the lists do not have the same length.
    def get_leftover(leftover_list, idx, ret):
        while idx < len(leftover_list):
            ret.append(leftover_list[idx])
            idx += 1
    
    get_leftover(half_one, h_one_idx, ret)
    get_leftover(half_two, h_two_idx, ret)

    return ret

```
**Time Complexity**: O(nlogn) for entire sort, O(n) for merging step