import unittest
import aoc2021pkg/day1
import aoc2021pkg/day2
import aoc2021pkg/day3
import aoc2021pkg/day4
import aoc2021pkg/day5
import aoc2021pkg/day6
import aoc2021pkg/day7

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

suite "day 4":
  setup:
    let filename = "./problem_input/day4/input.txt"
  test "part 1":
    check day4(filename) == 44736
  test "part 2":
    check day4_2(filename) == 1827

suite "day 5":
  setup:
    let filename = "./problem_input/day5/input.txt"
  test "part 1":
    check day5(filename) == 6841
  test "part 2":
    check day5_2(filename) == 19258

suite "day 6":
  setup:
    let filename = "./problem_input/day6/input.txt"
  test "part 1":
    check day6(filename) == 360610
  test "part 2":
    check day6_2(filename) == 1631629590423


suite "day 7":
  setup:
    let filename = "./problem_input/day7/input.txt"
  test "part 1":
    check day7(filename) == 354129
  test "part 2":
    check day7_2(filename) == 98905973
