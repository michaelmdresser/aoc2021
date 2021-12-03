import util

import math
import sequtils

proc lineToBitVector*(line: string): seq[bool] =
  for bit in line:
    if bit == '1':
      result.add(true)
    else:
      result.add(false)

proc mostCommonBitForColumn*(matrix: seq[seq[bool]], column: int, tiebreaker = true): bool =
  var trueCount = 0
  for row in matrix:
    if row[column]:
      trueCount += 1

  let falseCount = matrix.len - trueCount
  if trueCount == falseCount:
    return tiebreaker

  return trueCount >= ceilDiv(matrix.len, 2)

proc bitVectorToDecimal*(vec: seq[bool]): int =
  var power = 0
  for i in countdown(vec.len-1, 0):
    if vec[i]:
      result += 2 ^ power
    power += 1

proc commonColumnBits(matrix: seq[seq[bool]]): seq[bool] =
  let lineCount = matrix.len
  let columnCount = matrix[0].len

  var mostCommonBits = newSeq[bool]()
  for column in 0..<columnCount:
    mostCommonBits.add(mostCommonBitForColumn(matrix, column))

  return mostCommonBits

proc day3*(filename: string): int =
  let bitMatrix: seq[seq[bool]] = fileLinesToType[seq[bool]](filename, lineToBitVector)
  let mostCommonBits = commonColumnBits(bitMatrix)
  let leastCommonBits: seq[bool] = map(mostCommonBits, proc(x: bool): bool = not x)

  let gammaRate: int = bitVectorToDecimal(mostCommonBits)
  let epsilonRate: int = bitVectorToDecimal(leastCommonBits)
  return gammaRate * epsilonRate


# make a step function for easier testing
proc reduceMatrixByCriteriaOnce*(matrix: seq[seq[bool]], useMostCommon: bool, column: int): seq[seq[bool]] =
  # not elegant, but by tiebreaking common bit with true and then negating, we
  # get the desired behavior
  var filter = mostCommonBitForColumn(matrix, column)
  if not useMostCommon:
    filter = not filter

  proc filterFunc(row: seq[bool]): bool =
    return row[column] == filter

  return filter(matrix, filterFunc)

proc reduceMatrixByCriteria*(matrix: seq[seq[bool]], useMostCommon: bool): seq[bool] =
  var matrix = matrix
  var column = 0

  # trampoline instead of recursion for no good reason
  while matrix.len > 1:
    matrix = reduceMatrixByCriteriaOnce(matrix, useMostCommon, column)
    column += 1

  return matrix[0]


proc day3_2*(filename: string): int =
  let bitMatrix: seq[seq[bool]] = fileLinesToType[seq[bool]](filename, lineToBitVector)
  let mostCommonBits = commonColumnBits(bitMatrix)
  let leastCommonBits: seq[bool] = map(mostCommonBits, proc(x: bool): bool = not x)

  let oxygenRatingBits: seq[bool] = reduceMatrixByCriteria(bitMatrix, true)
  let co2RatingBits: seq[bool] = reduceMatrixByCriteria(bitMatrix, false)

  let oxygenRating = bitVectorToDecimal(oxygenRatingBits)
  let co2Rating = bitVectorToDecimal(co2RatingBits)

  return oxygenRating * co2Rating
