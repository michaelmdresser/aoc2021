import strutils
import sequtils

proc fileLinesToType*[T](filename: string, f: proc (line: string): T): seq[T] =
  let file = open(fileName)
  defer: file.close()

  result = newSeq[T]()
  var line: string
  while file.read_line(line):
    result.add(f(line))

  return result

proc fileFirstLineToInts*(filename: string): seq[int] =
  let file = open(fileName)
  defer: file.close()

  var line: string
  discard file.read_line(line)

  return map(split(line, ','), parseInt)
