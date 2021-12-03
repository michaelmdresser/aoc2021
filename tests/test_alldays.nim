import unittest
import aoc2021pkg/day1
import aoc2021pkg/day2
import aoc2021pkg/day3

# Once I have confirmed my solution to a problem, I'll add a unit test here.
# These test are dependent on the input which is committed in this repo. They
# enable me to refactor code if I want to make it better.

suite "day 1":
  setup:
    let filename = "./problem_input/day1/day1input.txt"
  test "part 1":
    check day1(filename) == 1387
  test "part 2":
    check day1_2(filename) == 1362

suite "day 2":
  setup:
    let filename = "./problem_input/day2/day2input.txt"
  test "part 1":
    check day2(filename) == 1868935
  test "part 2":
    check day2_2(filename) == 1965970888

suite "day 3":
  setup:
    let filename = "./problem_input/day3/day3input.txt"
  test "part 1":
    check day3(filename) == 1071734
  test "part 2":
    check day3_2(filename) == 6124992
