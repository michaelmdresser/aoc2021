import strutils

import util

type
  Position = object
    horizontal, depth: int

  Position2 = object
    horizontal, depth, aim: int

  Command = object
    kind: string
    amount: int

func processCommand(current: Position, cmd: Command): Position =
  var updated = current
  case cmd.kind:
    of "forward":
      updated.horizontal += cmd.amount
    of "down":
      updated.depth += cmd.amount
    of "up":
      updated.depth -= cmd.amount

  return updated


func processCommand2(current: Position2, cmd: Command): Position2 =
  var updated = current
  case cmd.kind:
    of "forward":
      updated.horizontal += cmd.amount
      updated.depth += current.aim * cmd.amount
    of "down":
      updated.aim += cmd.amount
    of "up":
      updated.aim -= cmd.amount

  return updated

proc lineToCommand(line: string): Command =
  let sp = split(line, " ")
  return Command(kind: sp[0], amount: parseInt(sp[1]))

proc day2*(filename: string): int =
  let start = Position()
  let commands = fileLinesToType[Command](filename, lineToCommand)
  var pos = start
  for command in commands:
    pos = processCommand(pos, command)

  return pos.horizontal * pos.depth

proc day2_2*(filename: string): int =
  let start = Position2()
  let commands = fileLinesToType[Command](filename, lineToCommand)
  var pos = start
  for command in commands:
    pos = processCommand2(pos, command)

  return pos.horizontal * pos.depth
