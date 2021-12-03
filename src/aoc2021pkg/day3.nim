import util

import math
import sequtils

proc lineToBitVector*(line: string): seq[bool] =
  for bit in line:
    if bit == '1':
      result.add(true)
    else:
      result.add(false)

proc mostCommonBitForColumn*(matrix: seq[seq[bool]], column: int): bool =
  var trueCount = 0
  for row in matrix:
    if row[column]:
      trueCount += 1

  return trueCount >= ceilDiv(matrix.len, 2)

proc bitVectorToDecimal*(vec: seq[bool]): int =
  var power = 0
  for i in countdown(vec.len-1, 0):
    if vec[i]:
      result += 2 ^ power
    power += 1

proc day3*(filename: string): int =
  let bitMatrix: seq[seq[bool]] = fileLinesToType[seq[bool]](filename, lineToBitVector)
  let lineCount = bitMatrix.len
  let columnCount = bitMatrix[0].len

  var mostCommonBits = newSeq[bool]()
  for column in 0..<columnCount:
    mostCommonBits.add(mostCommonBitForColumn(bitMatrix, column))

  let leastCommonBits: seq[bool] = map(mostCommonBits, proc(x: bool): bool = not x)

  let gammaRate: int = bitVectorToDecimal(mostCommonBits)
  let epsilonRate: int = bitVectorToDecimal(leastCommonBits)
  return gammaRate * epsilonRate
