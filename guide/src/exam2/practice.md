# Practice Problems

The following practice problems may be helpful for your preparation. You can expect the exam questions to be around the same level or a little
bit harder.

Some tips:

- Spend around 30 - 50 minutes working on a problem. If you are unable to make any substantial progress, look at a hint or the solution.
  Afterwards, **make sure you write the implementation yourself**.
- If you are able to solve the problem, try to understand other possible solutions.

For more information, visit: [official study guide](https://www.cs.utexas.edu/users/mitra/csSpring2022/cs313/notes/StudyGuide2.txt)

## _Worked Problems_

[LeetCode: Nim](https://leetcode.com/problems/nim-game/)

<details>
  <summary>Solution</summary>
  
  Let's start at the simplest cases and see if we can find a pattern:
  - n = 1, first player wins
  - n = 2, first player wins
  - n = 3,  first player wins

For n = 4, let's consider all the cases:

- picks 1 => n = 3, second player wins by taking 3
- picks 2 => n = 2, second player wins by taking 2
- picks 3 => n = 1, second player wins by taking 1

We can see that for each move, we have a new problem with a different number of n
and the player's positions swapping.

We might initially come up with a dynamic programming solution like this:

```python
class Solution:
  def canWinNim(self, n: int) -> bool:

      # initialize from 0 to n, ignore the first 0.
      dp = [None for i in range(n + 1)]

      # True = first player can win no matter what.
      # False = second player can win no matter what.

      # base cases:
      for i in range(1, 4):
          dp[i] = True

      # consider all cases from 4 to n.
      for i in range(4, n + 1):
          # loop back to consider cases for taking 1 - 3 stones
          for j in range(1, 4):

              # next second player (current first player) can win
              # immediately break.
              if not dp[i - j]:
                  dp[i] = True
                  break
          else:
              # for loop terminated without breaking. meaning it did not find a possible
              # win condition. first player cannot win.
              dp[i] = False
```

Can we do better? If you manually evaluted more points for n (or examined the contents of the dynamic programming array), you'll
find something interesting. Every 4th element is false (meaning it's impossible for the first player to win).

We can shorten this to a simple check:

```python
class Solution:
  def canWinNim(self, n: int) -> bool:
      return n % 4 != 0
```

Follow up: can you prove this using induction?

</details>

<br/>

[LeetCode: Search a 2D Matrix](https://leetcode.com/problems/search-a-2d-matrix/)

<details>
  <summary>Solution</summary>

The problem specifications hints towards a binary search. However, since this a matrix, we must modify our approach.
We can think of the matrix as a large array with the rows stacked on top of each other. Knowing this, we can set our
`low` and `high` to the appropriate bounds: `0` and `rows * columns - 1`, respectively. To get the row, we can use
`mid // columns`. To get the column we can use `mid % columns`.

```python
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        rows = len(matrix)
        cols = len(matrix[0])
        low = 0
        high = rows * cols - 1
        while low <= high:
            mid = low + (high - low) // 2
            row = mid // cols
            col = mid % cols
            val = matrix[row][col]
            if val == target:
                return True
            if val < target:
                low = mid + 1
            else:
                high = mid - 1
        return False
```

</details>

<br/>

[LeetCode: Remove Nth Node from End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)

<details>
  <summary>Solution</summary>
  
  In a singly linked list, only the forward connections are stored in the node. To get the backwards connections (or the previous node), we can
  use recursion. The back/previous connections are stored implicitly on the stack.

In the solution below, the helper function returns two values every time it's called: the new next node for the previous node and the previous
node's n-th position from the end.

On every function call, we update the current node's next. The current node's next is unchanged if the next node should not have been deleted.

The time complexity is O(n) because we do one full traversal of the linked list.

```python

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
  def removeNthFromEnd(self, head: ListNode, n: int) -> ListNode:

      def helper(node, place_to_remove):

          # reached the end, let the previous node
          # know that it's first
          if not node:
              return None, 1

          node_next, place = helper(node.next, place_to_remove)

          # update connection if necessary
          node.next = node_next

          # delete this node by returning this node's next to be updated
          updated_node = node.next if place == place_to_remove else node

          return updated_node, place + 1

      return helper(head, n)[0]

```

</details>

<br/>

[LeetCode: Valid Parantheses](https://leetcode.com/problems/valid-parentheses/)

<details>
<summary>Solution</summary>

Again, with problems like this it is good to write out some manual cases and manually identify if they are valid
(while doing this look for ways to formalize the patterns you observe into code):

- `((())) => OK`
- `((((() => WRONG`
- `{(}) => WRONG`
- `(())()) => WRONG`
- `)() => WRONG`

Some observations:

- Closing brackets must match with the opening brackets.
- Closing bracket pairs with the closest open bracket to its left.
- Each closing bracket must have an opening bracket to pair with.

Knowing this, we want to use a stack because we are concerned with the ordering of the open parantheses -- more specifically,
the most recent open parantheses we've found before.

In our algorithm, whenever we come across an open parantheses, we add it to our stack of unclosed parantheses. Whenever
we come across a closing parantheses, we want to check if the most recent open parantheses that we added matches it,
if it does pop the open paranthese from the stack (it's no longer unclosed).

The string is valid if our stack is empty at the end. This means we've cloesd all of our unopened parantheses.

```python

class Solution:
    def isValid(self, s: str) -> bool:


        stack = []
        close_to_open = { ')' : '(', ']' : '[', '}' : '{'}

        for char in s:
            # Must be an opening bracket
            if char not in close_to_open:
                stack.append(char)

            # Closing bracket
            else:
                # No opening bracket to match.
                if not stack:
                    return False

                # Opening bracket exists but doesn't match
                if close_to_open[char] != stack.pop():
                    return False

        return not stack

```

</details>

<br/>

[LeetCode: Letter Combinations Phone Number](https://leetcode.com/problems/letter-combinations-of-a-phone-number/)

<details>
  <summary>Solution</summary>
  
  Create a mapping of the digits to all the possible letters. Iterate through all of them to consider all possibilities.
  Add to the auxiliary data structure, make the recursive call, then backtrack by popping.

```python

class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        saved = {
            '1': [],
            '2': ['a', 'b', 'c'],
            '3': ['d', 'e', 'f'],
            '4': ['g', 'h', 'i'],
            '5': ['j', 'k', 'l'],
            '6': ['m', 'n', 'o'],
            '7': ['p', 'q', 'r', 's'],
            '8': ['t', 'u', 'v'],
            '9': ['w', 'x', 'y', 'z']
        }

        # edge case
        if not digits:
            return []

        def helper(result, digits, index, acc):
            if index == len(digits):
                result.append(''.join(acc))
                return

            combos = saved[digits[index]]
            for combo in combos:
                acc.append(combo)
                helper(result, digits, index + 1, acc)
                acc.pop()

        builder = []
        helper(builder, digits, 0, [])
        return builder

```

</details>

<br/>

[LeetCode: House Robber](https://leetcode.com/problems/house-robber/)

<details>
  <summary>Solution</summary>
  
  At every index, we have two choices: Rob this house or don't. If we rob this house, we have a smaller
  subproblem that excludes the nearby houses. If we don't, we have a smaller subproblem that excludes
  the current house. At first, a brute force approach might seem appropriate, but let's see if we can
  optimize this even further with memoization.

Let's define `DP[i]` as the maxmimum money we can rob by considering all houses from indices 0 to i.
Our recurrence can be something like: `DP[i + 1] = max(DP[i], DP[i - 1] + money[i])`. At index `i + 1`,
we can either pick this house and add the optimal subproblem of `i - 1` or we can exclude this house
and pick the optimal subproblem of `i`.

```python

class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]

        dp = [0] * len(nums)

        # base cases
        dp[0] = nums[0]
        dp[1] = max(dp[0], nums[1])

        for i in range(2, len(nums)):
            dp[i] = max(dp[i-2] + nums[i], dp[i-1])

        # last index considers all the homes
        return dp[-1]

```

</details>

## _Additional Problems_

- [Leetcode: Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/)
- [Leetcode: Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/)
- [Kattis: Longest Increasing Subsequence [Dynamic Programming]](https://open.kattis.com/contests/wf6xh5/problems/longincsubseq)
- [LeetCode: Restore IP Addresses [Recursive Backtracking]](https://leetcode.com/problems/restore-ip-addresses/)
- [LeetCode: Ternary Expression Parser [Stacks]](https://leetcode.com/problems/ternary-expression-parser/)
- [LeetCode: Search Insert Position](https://leetcode.com/problems/search-insert-position/)
