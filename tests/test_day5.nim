import aoc2021pkg/day5

import unittest

suite "example":
  test "part 1":
    check day5("./problem_input/day5/example.txt") == 5
  test "part 2":
    let overlaps = day5_2("./problem_input/day5/example.txt")
    check overlaps == 12

suite "day 5 utils":
  test "lineToSegment":
    check lineToSegment("8,0 -> 0,8") == Segment(p1: nPoint(8, 0), p2: nPoint(0, 8))

  test "isHorizontal false":
    check isHorizontal(lineToSegment("1,2 -> 1,3")) == false

  test "isHorizontal true":
    check isHorizontal(lineToSegment("5,2 -> 7,2")) == true

  test "isVertical false":
    check isVertical(lineToSegment("5,2 -> 7,2")) == false

  test "isVertical true":
    check isVertical(lineToSegment("1,2 -> 1,3")) == true

  test "isHorizontalOrVertical false":
    let s = lineToSegment("5,2 -> 7,3")
    check s.isHorizontal or s.isVertical == false

  test "markGridWithSegment horiz":
    let grid: seq[seq[int]] = @[
      @[0, 0, 0],
      @[0, 0, 0],
      @[0, 0, 0],
    ]

    let s = Segment(
      p1: nPoint(1, 1),
      p2: nPoint(2, 1),
    )

    # this is transposed because i do [x][y] but the way the
    # lists work it looks like [y][x]
    let expectedGrid: seq[seq[int]] = @[
      @[0, 0, 0],
      @[0, 1, 0],
      @[0, 1, 0],
    ]

    check markGridWithSegment(grid, s) == expectedGrid

  test "markGridWithSegment diag":
    let grid: seq[seq[int]] = @[
      @[0, 0, 0],
      @[0, 0, 0],
      @[0, 0, 0],
    ]

    let s = Segment(
      p1: nPoint(1, 0),
      p2: nPoint(0, 1),
    )

    # this is transposed because i do [x][y] but the way the
    # lists work it looks like [y][x]
    let expectedGrid: seq[seq[int]] = @[
      @[0, 1, 0],
      @[1, 0, 0],
      @[0, 0, 0],
    ]

    let marked = markGridWithSegment(grid, s)

    check marked == expectedGrid


  test "markGridWithSegment reverse":
    let grid: seq[seq[int]] = @[
      @[0, 0, 0],
      @[0, 0, 0],
      @[0, 0, 0],
    ]

    let s = Segment(
      p1: nPoint(1, 2),
      p2: nPoint(2, 1),
    )

    # this is transposed because i do [x][y] but the way the
    # lists work it looks like [y][x]
    let expectedGrid: seq[seq[int]] = @[
      @[0, 0, 0],
      @[0, 0, 1],
      @[0, 1, 0],
    ]

    check markGridWithSegment(grid, s) == expectedGrid
