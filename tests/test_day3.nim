import unittest
import sequtils
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


test "mostCommonBitForColumn tie true":
  check mostCommonBitForColumn(@[
    @[false, false, true],
    @[false, true, true],
    @[true, true, true],
    @[true, true, true],
  ], 0) == true

test "mostCommonBitForColumn tie false":
  check mostCommonBitForColumn(@[
    @[false, false, true],
    @[false, true, true],
    @[true, true, true],
    @[true, true, true],
  ], 0, false) == false

const providedTestData: seq[seq[bool]] = map(@[
  "00100",
  "11110",
  "10110",
  "10111",
  "10101",
  "01111",
  "00111",
  "11100",
  "10000",
  "11001",
  "00010",
  "01010",
  ], lineToBitVector)

test "reduceMatrixByCriteria oxygen":
  check reduceMatrixByCriteria(providedTestData, true) == @[true, false, true, true, true]


suite "reduceMatrixByCriteriaOnce co2":
  setup:
    let expectedFirstResult = map(@[
      "00100",
      "01111",
      "00111",
      "00010",
      "01010",
    ], lineToBitVector)

    let expectedSecondResult = map(@[
      "01111",
      "01010"
     ], lineToBitVector)

    let expectedThirdResult = map(@[
      "01010"
     ], lineToBitVector)

  test "first step":
    check reduceMatrixByCriteriaOnce(providedTestData, false, 0) == expectedFirstResult

  test "second step":
    check reduceMatrixByCriteriaOnce(expectedFirstResult, false, 1) == expectedSecondResult

  test "third step":
    check reduceMatrixByCriteriaOnce(expectedSecondResult, false, 2) == expectedThirdResult

  test "all steps":
    check reduceMatrixByCriteria(providedTestData, false) == expectedThirdResult[0]
