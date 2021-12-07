import sequtils
import math
import std/algorithm

import util


### Median is not currently in Nim's stats package. There is an open
### PR: https://github.com/nim-lang/Nim/pull/17756
#
# Simple median instead
# ALWAYS ROUNDS DOWN
proc median*(nums: seq[int]): int =
  let s = sorted(nums)

  # [0, 1, 2, 3]
  # s.len / 2 = 2
  # (s.len / 2) - 1 = 1
  let median_idx = int(ceil((s.len / 2) - 1))

  return s[median_idx]

proc day7*(filename: string): int =
  # var for the median impl
  var starting_positions: seq[int] = fileFirstLineToInts(filename)
  let m: int = median(starting_positions)
  let distances: seq[int] = map(starting_positions, proc (pos: int): int = pos - m)
  let total_fuel = foldl(distances, a + abs(b), 0)
  return total_fuel
