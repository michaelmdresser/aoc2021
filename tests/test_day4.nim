import unittest

import aoc2021pkg/day4

suite "BingoBoard":
  test "hasBingo row":
    let board = BingoBoard(
      numbers: @[
        @[1, 2, 3],
        @[4, 5, 6],
        @[7, 8, 9],
      ],
      marked: @[
        @[false, true, false],
        @[true, true, true],
        @[false, false, false],
      ]
    )

    check hasBingo(board) == true

  test "hasBingo column":
    let board = BingoBoard(
      numbers: @[
        @[1, 2, 3],
        @[4, 5, 6],
        @[7, 8, 9],
      ],
      marked: @[
        @[false, true, true],
        @[true, false, true],
        @[false, false, true],
      ]
    )

    check hasBingo(board) == true

  test "unmarkedSum":
    let board = BingoBoard(
      numbers: @[
        @[1, 2, 3],
        @[4, 5, 6],
        @[7, 8, 9],
      ],
      marked: @[
        @[false, true, true],
        @[true, false, true],
        @[false, false, true],
      ]
    )

    check unmarkedSum(board) == (1 + 5 + 7 + 8)


  test "updateForDraw":
    let board = BingoBoard(
      numbers: @[
        @[1, 2, 3],
        @[4, 5, 6],
        @[7, 8, 9],
      ],
      marked: @[
        @[false, true, true],
        @[true, false, true],
        @[false, false, true],
      ]
    )
    check board.updateForDraw(8).marked[2][1] == true

suite "day 4 example":
  test "load day 4 example input":
    let (draws, boards) = loadInput("./problem_input/day4/example.txt")

    check draws == @[7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]

    check boards[0].numbers == @[
      @[22, 13, 17, 11, 0],
      @[8, 2, 23, 4, 24],
      @[21, 9, 14, 16, 7],
      @[6, 10, 3, 18, 5],
      @[1, 12, 20, 15, 19],
    ]

  test "part 1":
    check day4("./problem_input/day4/example.txt") == 4512

  test "part 2":
    check day4_2("./problem_input/day4/example.txt") == 1924
