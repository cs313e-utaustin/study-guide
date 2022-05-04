# Practice Problems

The following practice problems may be helpful for your preparation. You can expect the exam questions to be around the same level or a little
bit harder.

Some tips:

- Spend around 30 - 50 minutes working on a problem. If you are unable to make any substantial progress, look at a hint or the solution.
  Afterwards, **make sure you write the implementation yourself**.
- If you are able to solve the problem, try to understand other possible solutions.

For more information, visit: [official study guide](https://www.cs.utexas.edu/users/mitra/csSpring2022/cs313/notes/StudyGuide3.txt)

> *Note*:
>
> The 3rd exam will be structured differently from the other two. There will be a short answer section in addition to the coding portion.
> For the coding portion, choose three out of the five problems to solve.
> The short answer section will cover a simulation of a graph algorithm discussed in class (Prim's, Dijkstra's, etc...) as well
> as a tabulation DP problem.

## _Worked Problems_

[LeetCode: Count Good Nodes in Binary Tree [Trees]](https://leetcode.com/problems/count-good-nodes-in-binary-tree/)

<details>
  <summary>Solution</summary>

An important observation is that the path from the root to any node in the tree is unique (due to the fact that
every node has exactly one parent). We can traverse the tree using DFS and build our path accordingly. We don't
actually need to store the entire path since we are only concerned about the maximum along the path.

A possible recursive solution:

```python
class Solution:
    def goodNodes(self, root: TreeNode) -> int:
        def helper(node, maxi):
            """
                Returns the number of good nodes for the subtree at `node`.

                `node`: root of the subtree to evaluate
                `maxi`: the maximum value from the root to the parent of `node`
                        (inclusive).
            """
            # null node, return 0 for no good nodes.
            if not node:
                return 0

            count = 0

            # check if this node is good.
            maxi = max(maxi, node.val)
            if maxi == node.val:
                count += 1
            
            # add contributions from left and right.
            count += helper(node.left, maxi)
            count += helper(node.right, maxi)
            
            return count
        return helper(root, -math.inf)

```

A possible iterative solution (same algorithm):

```python

class Solution:
    def goodNodes(self, root: TreeNode) -> int:
        
        count = 0
        stack = []
        
        stack.append((root, -math.inf))
        
        while stack:
            cur, maxi = stack.pop()
            
            if not cur:
                continue
            
            maxi = max(maxi, cur.val)
            if maxi == cur.val:
                count += 1
            
            stack.append((cur.left, maxi))
            stack.append((cur.right, maxi))
        
        return count

```
</details>

<br/>

[LeetCode: Keys and Rooms [Graphs]](https://leetcode.com/problems/keys-and-rooms/)

<details>
  <summary>Solution</summary>
  
The problem is essentially asking if the graph is connected. Using DFS or BFS from the starting room
(room 0), we can visit all the rooms reachable. Once we've completed our graph traversal, we can check
if we've reached every room by comparing the length of the visited set to the number of rooms.

The `deque` class used here is a double-ended queue. We use this class for faster append and pop operations.
`popLeft()` is equivalent to `pop(0)` in that they both pop the first element from the queue, however, 
`pop(0)` executes in N<sup>2</sup> runtime complexity due to the shifting of elements whereas `popLeft()`
happens in constant time.
  
  ```python

from collections import deque

class Solution:
    def canVisitAllRooms(self, rooms: List[List[int]]) -> bool:
        
        # use queue for breadth first search.
        queue = deque()
        queue.append(0)

        # keep track of visited rooms.
        visited = set()
        while queue:
            cur = queue.popleft()

            # already visited, ignore.
            if cur in visited:
                continue
            visited.add(cur)
            
            room = rooms[cur]

            # add rooms reachable from here.
            for key in room:
                queue.append(key)
        
        return len(visited) == len(rooms)

````

</details>

<br/>

[LeetCode: Maximum Subarray [Dynamic Programming]](https://leetcode.com/problems/maximum-subarray/)

<details>
<summary>Solution</summary>

The brute force solution solves this in quadratic time (consider every single
possible contiguous subarray). We can speed this up using dynamic programming/memoization:
rather than recomputing the sums every time, we can store it on every iteration. Additionally,
the problem is only asking for the maximum sum, so we don't need to store every sum
for every possible pair of start/end indices.

Let's define `DP[i]` as the maximum subarray sum ending at index `i` (inclusive). When we
consider the `i + 1`th index, we have two options:

1. Include the previous maximum sum (we can guarantee it is contiguous because it ends on the index before).
2. Don't include the previous maxmium sum, only include the current number.

Now we can find the maximum subarray sum in linear time.

A potential solution:
```python

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        
        dp = [0] * len(nums)
        
        best = -math.inf
        for i, num in enumerate(nums):
            if i == 0:
                dp[i] = num
            else:
                dp[i] = max(nums[i], dp[i - 1] + nums[i])
            best = max(dp[i], best)
        return best

````

This algorithm is known as Kadane's algorithm.

Follow-up: can you optimize this to be O(1) in space?

</details>

<br/>

[LeetCode: House Robber III [Trees + Dynamic Programming]](https://leetcode.com/problems/house-robber-iii/)

<details>
  <summary>Solution</summary>
  
  At a single node we have two options:
  1. Rob the node, don't rob the children of the node.
  2. Don't rob the node, consider robbing the children of the node.

  For each node, we memoize the best/maxmium profit gained from each of the two conditions (with and without)
  and then utilize the recursive substructure of the tree to propogate the values up to the root.
  
  The trickiest part is in the second case where we don't rob the code -- we need to consider all four combinations
  between the maximums including the left and the right and the maximums not including the left and the right. It
  is not always optimal to rob the children of the node in the second case.
  
  See comments in the code for more information.

```python

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Solution:
    def rob(self, root: Optional[TreeNode]) -> int:
        
        def helper(node):
            if node is None:
                return 0, 0
            
            with_l, without_l = helper(node.left)
            with_r, without_r = helper(node.right)
            
            # if we rob this house, we have to pick the ones without.
            with_node = node.val + without_l + without_r
            
            # all possible combinations of with_l, without_l and with_r, without_r
            # these are all possible if we don't rob the current node.
            possibles = [x + y for x in [with_l, without_l] for y in [with_r, without_r]]
            
            return with_node, max(possibles)
        
        
        return max(helper(root))

```

</details>

<br/>

[Kattis: Knight Jump [Graphs]](https://open.kattis.com/problems/knightjump)

<details>
  <summary>Solution</summary>
  
  We can model this problem like a graph. The nodes are the squares of the board. An edge exists between
  two nodes if a knight can jump from one node to another. We can use either DFS or BFS to determine if
  the target square is reachable. However, the problem stipulates that we need to find the minimum number
  of moves.

  In order to find the minimum, we must use BFS. Remember that from a starting vertex, BFS finds the
  shortest unweighted path to every other connected vertex. To return the number of moves required,
  we can store the distance as part of the BFS state along with the node.

```python

from collections import deque

# single integer
inp = lambda: int(input())

# string list
strl = lambda: list(input().strip())

# in bounds check for 2d array
in_bounds = lambda x, y, grid: x >= 0 and x < len(grid) and y >= 0 and y < len(grid[0])


def valid(coord, board):
    """ Checks if coordinate is valid. """
    return in_bounds(*coord, board) and board[coord[0]][coord[1]] != '#'

def solve(board):
    start = None

    # finding the start.
    for i, row in enumerate(board):
        for j, elem in enumerate(row):
            if elem == 'K':
                start = (i, j)

    
    assert start is not None

    queue = deque([(start, 0)])
    visited = set()

    # all different knight movements.
    movement = [
        (2, 1),
        (2, -1),
        (-2, 1),
        (-2, -1),
        (1, 2),
        (1, -2),
        (-1, 2),
        (-1, -2)
    ]

    # perform bfs.
    while queue:
        cur, dist = queue.popleft()

        # reached the target, return `dist` immediately.
        if cur[0] == 0 and cur[1] == 0:
            return dist

        # already visited or not a valid square.
        if cur in visited or not valid(cur, board):
            continue

        visited.add(cur)

        # add next possible moves.
        for move in movement:
            delta = (
                (cur[0] + move[0], cur[1] + move[1]),
                dist + 1
            )
            
            queue.append(delta)
    
    return -1

if __name__ == '__main__':
    
    n = inp()
    board = []
    
    for _ in range(n):
        board.append(strl())
    
    print(solve(board))

```

</details>

</br>

[LeetCode: Decode Ways [Dynamic Programming]](https://leetcode.com/problems/decode-ways/)

<details>
  <summary>Solution</summary>
  
  The first important observation is that the encoded numbers are at most two digits. That means for a given
  index `i`, we need to consider the single digit number (character at `i`) as well as the double digit
  number (substring `i - 1` to `i`).

  Once we've fixed a single number, we need to consider the number of ways to decode for the remaining substring.
  A possible recursive/brute force solution might add the following two numbers together for string `s`.
  1. Fixed single digit number at `i`: `decode_ways(s[:i])`
  2. Fixed double digit number `[i-1:i+1]`: `decode_ways([s:i-1])`

  Notice that we are always recomputing the decode ways for the beginning of the string, we can use bottom-up memoization
  to speed up our algorithm.

```python

class Solution:
    def numDecodings(self, s: str) -> int:
        
        # all valid encodings.
        valid_numbers = set([str(i) for i in range(1, 27)])
        
        # dp[i] stores number of ways to decode for substring up to index i
        dp = [0] * (len(s) + 1)
        
        # base cases
        dp[0] = 1        
        dp[1] = 1 if s[0] in valid_numbers else 0

        if len(s) == 1:
            return dp[1]
        
        for i in range(2, len(s) + 1):
            
            # separate index for string since i is exclusive
            str_idx = i - 1
            
            # consider the case where we fix a single digit number
            dp[i] += dp[i - 1] if s[str_idx] in valid_numbers else 0

            # consider the case where we fix a double digit number
            dp[i] += dp[i - 2] if s[str_idx-1:str_idx+1] in valid_numbers else 0
        
        return dp[len(s)]

```


</details>

<br/>

[LeetCode: Validate BST [Trees]](https://leetcode.com/problems/validate-binary-search-tree/)

<details>
  <summary>Solution</summary>
  
  An important binary search tree property is that the entire subtree of the right must be greater than the root node and the
  entire subtree of the left must be less than the root node. It's not enough to check the children in order to validate the
  BST.

  When inserting a node into the BST, there is only one place where the node can be placed (according to our BST algorithm).
  Intuitively, each node acts as a range check for the node being inserted. We can use this same principle in order
  to validate the BST.

```python

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Solution:
    def isValidBST(self, root: TreeNode) -> bool:
        return self.helper(root, -math.inf, math.inf)

    def helper(self, node: TreeNode, min_b: int, max_b: int) -> bool:
        if node is None:
            return True

        # falls within proper range
        ok = node.val >= min_b and node.val <= max_b
        
        # check left and right, left max is node.val - 1, right min is node.val + 1
        return ok and self.helper(node.left, min_b, node.val - 1) and self.helper(node.right, node.val + 1, max_b)

```


</details>


## _Additional Problems_
- [Leetcode: Maximum Sum Circular Subarray [Dynamic Programming]](https://leetcode.com/problems/maximum-sum-circular-subarray/)
- [Leetcode: Invert Binary Tree [Trees]](https://leetcode.com/problems/invert-binary-tree/)
- [LeetCode: Is Graph Bipartite [Graph]](https://leetcode.com/problems/is-graph-bipartite/)
- [Codeforces: Fall Down [Graph]](https://codeforces.com/problemset/problem/1669/G)
- [Kattis: Mountain Scenes [Dynamic Programming]](https://open.kattis.com/problems/scenes)
