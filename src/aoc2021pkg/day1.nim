import std/strutils

import util

proc numberOfIncreases*(numbers: seq[int]): int =
  result = 0
  for i in 1 ..< numbers.len:
    if numbers[i] > numbers[i - 1]:
      result += 1


proc numberOfSlidingIncreases(numbers: seq[int]): int =
  var threedaysums = newSeq[int]()
  for i in 2 ..< numbers.len:
    threedaysums.add(numbers[i - 2] + numbers[i - 1] + numbers[i])

  return numberOfIncreases(threedaysums)

proc day1*(filename: string): int =
  return numberOfIncreases(fileLinesToType[int](filename, parseInt))

proc day1_2*(fileName: string): int =
  return numberOfSlidingIncreases(fileLinesToType[int](filename, parseInt))
