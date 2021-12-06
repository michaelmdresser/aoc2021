import aoc2021pkg/day6
import unittest

suite "example":
  test "part 1":
    check day6("./problem_input/day6/example.txt") == 5934
  test "part 2":
    check day6_2("./problem_input/day6/example.txt") == 26984457539
