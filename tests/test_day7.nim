import aoc2021pkg/day7
import unittest

suite "example":
  test "part 1":
    check day7("./problem_input/day7/example.txt") == 37
  test "part 2":
    check day7_2("./problem_input/day7/example.txt") == 168


suite "median":
  test "even elements":
    check median(@[4, 1, 3, 2]) == 2

  test "odd elements":
    check median(@[4, 1, 3]) == 3
