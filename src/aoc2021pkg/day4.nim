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

proc unmarkedSum*(board: BingoBoard): int =
  for row in 0..<board.numbers.len:
    for column in 0..<board.numbers[row].len:
      if not board.marked[row][column]:
        result += board.numbers[row][column]

proc updateForDraw*(board: BingoBoard, draw: int): BingoBoard =
  var board = board # shadow so we can update
  for row in 0..<board.numbers.len:
    for column in 0..<board.numbers[row].len:
      if board.numbers[row][column] == draw:
        board.marked[row][column] = true
        return board

  return board

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
  var (draws, boards) = loadInput(filename)

  for draw in draws:
    for idx, board in boards.pairs:
      let newBoard = board.updateForDraw(draw)
      boards[idx] = newBoard

      if newBoard.hasBingo():
        return newBoard.unmarkedSum() * draw

proc day4_2*(filename: string): int =
  var (draws, boards) = loadInput(filename)

  while true:
    # update boards for the next draw
    boards = map(boards, proc (b: BingoBoard): BingoBoard = updateForDraw(b, draws[0]))

    # once we're on the last board, we only want to update the last
    # board, not filter it out
    if boards.len > 1:
      # filter out boards that have bingo
      boards = filter(boards, proc (b: BingoBoard): bool = not hasBingo(b))

    if boards.len == 1 and boards[0].hasBingo:
      return draws[0] * boards[0].unmarkedSum()

    draws = draws[1..^1]
