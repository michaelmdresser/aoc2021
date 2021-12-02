import strutils

type
  Position = object
    horizontal, depth: int

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


proc fileToCommands(filename: string): seq[Command] =
  let f = open(fileName)
  defer: f.close()

  var commands = newSeq[Command]()
  var line: string
  while f.read_line(line):
    let sp = split(line, " ")
    commands.add(Command(kind: sp[0], amount: parseInt(sp[1])))

  return commands

proc day2*(filename: string): int =
  let start = Position()
  let commands = fileToCommands(filename)
  var pos = start
  for command in commands:
    pos = processCommand(pos, command)

  return pos.horizontal * pos.depth
