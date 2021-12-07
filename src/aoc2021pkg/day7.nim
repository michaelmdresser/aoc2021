import sequtils
import math
import std/algorithm
import tables

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
  let starting_positions: seq[int] = fileFirstLineToInts(filename)
  let m: int = median(starting_positions)
  let distances: seq[int] = map(starting_positions, proc (pos: int): int = pos - m)
  let total_fuel = foldl(distances, a + abs(b), 0)
  return total_fuel

proc day7_2*(filename: string): int =
  proc fuel_required(pos1, pos2: int): int =
    var s = 0
    for step in 1..abs(pos1 - pos2):
      s += step

    return s

  let starting_positions: seq[int] = fileFirstLineToInts(filename)
  var count_for_position = initCountTable[int]()
  for pos in starting_positions:
    count_for_position.inc(pos)

  let min_position: int = min(starting_positions)
  let max_position: int = max(starting_positions)

  proc total_fuel_required(target: int, count_for_position: CountTable[int]): int =
    var s = 0
    for position, count in count_for_position:
      s += count * fuel_required(position, target)

    return s

  var best_position = min_position
  var best_fuel = total_fuel_required(min_position, count_for_position)

  for target in min_position..max_position:
    let fuel_cost = total_fuel_required(target, count_for_position)
    if fuel_cost < best_fuel:
      best_fuel = fuel_cost
      best_position = target

  return best_fuel
