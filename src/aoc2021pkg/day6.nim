import sequtils
import strutils
import tables

import util

proc advance_generation(lifetime_counts: CountTable[int]): CountTable[int] =
  var newCounts: CountTable[int] = initCountTable[int]()
  for lifetime, fish in lifetimeCounts:
    if lifetime == 0:
      newCounts.inc(6, val=fish)
      newCounts.inc(8, val=fish)
    else:
      newCounts.inc(lifetime - 1, val=fish)

  return newCounts

proc day6*(filename: string, days: int = 80): int =
  let starting_lifetimes: seq[int] = fileFirstLineToInts(filename)

  # lifetimeCounts[lifetime] = number of fish with that lifetime
  var lifetimeCounts: CountTable[int] = initCountTable[int]()
  for lifetime in starting_lifetimes:
    lifetimeCounts.inc(lifetime)

  for elapsed_days in 0..<days:
    lifetimeCounts = advance_generation(lifetimeCounts)

  var total_fish = 0
  for _, fish in lifetimeCounts:
    total_fish += fish

  return total_fish
