# Practice Problems

The following practice problems may be helpful for your preparation. You can expect the exam questions to be around the same level or a little
bit harder.

Some tips:

- Spend around 30 - 50 minutes working on a problem. If you are unable to make any substantial progress, look at a hint or the solution.
Afterwards, **make sure you write the implementation yourself**.
- If you are able to solve the problem, try to understand other possible solutions.

## *Worked Problems*

[LeetCode: Rotate String](https://leetcode.com/problems/rotate-string/)
<details>
  <summary>Solution</summary>
  
  We can generate all rotations of the string by concatenating the two strings together and checking
  if the substring is present.
  
  ```python

 class Solution:
    def rotateString(self, s: str, goal: str) -> bool:
        all_rotations = s * 2
        return len(s) == len(goal) and goal in all_rotations

  ```
  
</details>

<br/>

[LeetCode: Two Sum](https://leetcode.com/problems/two-sum/)
<details>
  <summary>Solution</summary>
  
  The important realization here is that each number's complement (target - number) is unique. Using this information,
  we can leverage the dictionary's uniqueness key property to store the complement and the index as a key value pair.
  
  ```python

  class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        
        mapping = {}
        for idx, num in enumerate(nums):
            
            # We found the complement.
            if num in mapping:
                return [idx, mapping[num]]
            
            # Store the complement and its index.
            mapping[target - num] = idx

  ```
  
</details>

<br/>

[LeetCode: Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)

<details>
  <summary>Solution</summary>
  
  The most difficult part of this is ensuring that we sell after buying the sock (i.e, the peak must be after the trough).
  To do this, let's consider every potential day as a selling day and keep track of the minimum. This way, we guarantee that
  we've passed the minimum before we sell.
  
  ```python

class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        max_profit = 0
        
        # Initialize minimum to Infinity.
        minimum = math.inf

        for price in prices:
            minimum = min(price, minimum)
            max_profit = max(max_profit, price - minimum)
        return max_profit

```

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

[LeetCode: Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)


<details>
  <summary>Solution</summary>
  
  We can keep track of the rows and columns to set to 0 by using a set. There is another solution which has
  constant space complexity, but for our exam purposes the below solution will be fine. Submissions will not
  be graded on efficiency for this exam.

```python

class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """
        
        rows = set()
        cols = set()
        
        for i in range(len(matrix)):
            for j in range(len(matrix[i])):
                if matrix[i][j] == 0:
                    rows.add(i)
                    cols.add(j)
        
        def set_row(row, matrix):
            for j in range(len(matrix[row])):
                matrix[row][j] = 0

        def set_col(col, matrix):
            for i in range(len(matrix)):
                matrix[i][col] = 0
                           
        for row in rows:
            set_row(row, matrix)
        
        for col in cols:
            set_col(col, matrix)

```

  
</details>

<br/>

[LeetCode: Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/)

<details>
  <summary>Solution</summary>
  
  A palindrome is symmetrical. Knowing this, we can consider every potential starting midpoint for the palindrome
  and expand outwards to count the number of valid palindromes. We'll also need to handle an edge case for even-lengthed
  palindromes.

```python

class Solution:
    def countSubstrings(self, s: str) -> int:
        
        size = len(s)
        
        def expand_outwards(s, left, right):
            
            count = 0
            
            # Expand outwards while left and right pointers are the same character.
            while (left >= 0 and right < len(s) and s[left] == s[right]):
                left -= 1
                right += 1
                count += 1

            return count
        
        total = 0
        for center in range(size):
            
            # For odd-lengthed palindromes.
            total += expand_outwards(s, center, center)
            
            # For even-lengthed palindromes.
            total += expand_outwards(s, center - 1, center)
        return total

```  
</details>

<br/>

[LeetCode: Find Winner on a Tic Tac Toe Game](https://leetcode.com/problems/find-winner-on-a-tic-tac-toe-game/)

<details>
  <summary>Solution</summary>
  
  There are many possible solutions to this problem. A brute force approach is completely acceptable. The below
  approach is a more optimized/clean solution. The main idea is to keep track of all 8 possible win conditions
  for each player (3 rows + 3 columns + 2 diagonals). The win conditions are kept track of using a counter.
  Whenever a counter reaches 3, then that player has won.

```python

class Solution:
    def tictactoe(self, moves: List[List[int]]) -> str:
        
        # Keep track of all 8 possible win conditions for each
        # player.
        winner_a = [0] * 8
        winner_b = [0] * 8
        
        # Iterate through the moves.
        for idx, pair in enumerate(moves):
            
            # Determine who the current player is.
            arr = winner_a if idx % 2 == 0 else winner_b
            x, y = pair
            
            # Increment row 'win' counter.
            arr[x] += 1
            
            # Increment col 'win' counter.
            arr[y + 3] += 1
            
            # Increment diagonal 'win' counter.
            if x == y:
                arr[6] += 1
                
            # Increment anti-diagonal 'win' counter.
            if x == 2 - y:
                arr[7] += 1
        
        # Check all win conditions.
        for i in range(8):
            if winner_a[i] == 3:
                return "A"
            if winner_b[i] == 3:
                return "B"
        
        return "Draw" if len(moves) == 9 else "Pending"

```  
</details>

<br/>

[LeetCode: Surface Area of 3D Shapes](https://leetcode.com/problems/surface-area-of-3d-shapes/)

<details>
  <summary>Solution</summary>
  
  It's easier to consider each stack of cubes as standalone and then subtract the sides that are covered by
  the surround cubes.

```python

class Solution:
    def surfaceArea(self, grid: List[List[int]]) -> int:
        
        # Function for checking if in bounds.
        in_bounds = lambda r, c: 0 <= r < len(grid) and 0 <= c < len(grid[0])

        total = 0
        
        # Directions for left, up, right, and down.
        dirs = [
            (1, 0),
            (0, 1),
            (-1, 0),
            (0, -1)
        ]
        
        total = 0
        for i in range(len(grid)):
            for j in range(len(grid[i])):
                
                # Ignore if there is a hole here.
                if grid[i][j] == 0:
                    continue
                
                # 2 for the top-down faces, 4 for the lateral sides.
                sa = 2 + 4 * grid[i][j]
                
                for delta_x, delta_y in dirs:
                    r = i + delta_x
                    c = j + delta_y
                    
                    if not in_bounds(r, c):
                        continue
                    
                    # Subtract neighboring faces.
                    sa -= min(grid[r][c], grid[i][j])
                total += sa

        return total

```  
</details>

## *Additional Problems*

- [Kattis: Eye of Sauron](https://naq21.kattis.com/problems/eyeofsauron)
- [LeetCode: Search Insert Position](https://leetcode.com/problems/search-insert-position/)
- [LeetCode: Insert Interval](https://leetcode.com/problems/insert-interval/)
- [LeetCode: Verifying an Alien Dictionary](https://leetcode.com/problems/verifying-an-alien-dictionary/)
- [LeetCode: Subrectangle Queries](https://leetcode.com/problems/subrectangle-queries/)
- [Codeforces: Cute Pets](https://codeforces.com/gym/103270/problem/F)
