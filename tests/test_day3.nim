import unittest
import aoc2021pkg/day3

test "bitVectorToDecimal":
  check bitVectorToDecimal(@[true, false, true]) == 5

test "lineToBitVector":
  check lineToBitVector("01001") == @[false, true, false, false, true]

test "mostCommonBitForColumn true":
  check mostCommonBitForColumn(@[
    @[true, false, true],
    @[false, true, true],
    @[true, true, true],
  ], 1) == true

test "mostCommonBitForColumn false":
  check mostCommonBitForColumn(@[
    @[false, false, true],
    @[false, true, true],
    @[true, true, true],
  ], 0) == false
