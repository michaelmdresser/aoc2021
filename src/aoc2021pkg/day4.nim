import sequtils
import strutils

import util

type
  BingoBoard* = object
    numbers*: seq[seq[int]]
    marked*: seq[seq[bool]]

proc hasBingo*(board: BingoBoard): bool =
  for row in 0..<board.numbers.len:
    var hasRowBingo = true
    for column in 0..<board.numbers[row].len:
      if not board.marked[row][column]:
        hasRowBingo = false
        break

    if hasRowBingo:
      return true

  for column in 0..<board.numbers[0].len:
    var hasColumnBingo = true
    for row in 0..<board.numbers.len:
      if not board.marked[row][column]:
        hasColumnBingo = false
        break

    if hasColumnBingo:
      return true

  return false


proc loadInput*(filename: string): (seq[int], seq[BingoBoard]) =
  let file = open(filename)
  defer: file.close()

  var line: string
  discard file.read_line(line) # first line is the draws
  let draws: seq[int] = map(split(line, ','), parseInt)

  discard file.read_line(line) # second line is blank

  var boards: seq[BingoBoard] = newSeq[BingoBoard]()
  var currentBoard = BingoBoard(
    numbers: newSeq[seq[int]](),
    marked: newSeq[seq[bool]](),
  )
  while file.read_line(line):
    line = strip(line)
    if line.len == 0:
      boards.add(currentBoard)
      currentBoard = BingoBoard(
        numbers: newSeq[seq[int]](),
        marked: newSeq[seq[bool]](),
      )
      continue

    let lineNumbers = map(splitWhitespace(line), parseInt)
    let lineMarked = repeat(false, lineNumbers.len)
    currentBoard.numbers.add(lineNumbers)
    currentBoard.marked.add(lineMarked)

  if currentBoard.numbers.len > 0:
    boards.add(currentBoard)

  return (draws, boards)



proc day4*(filename: string): int =
  let (draws, boards) = loadInput(filename)
