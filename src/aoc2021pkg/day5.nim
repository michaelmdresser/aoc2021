import sequtils
import strutils
import tables

import util

type
  Point* = object
    x*, y*: int

  Segment* = object
    p1*, p2*: Point

proc nPoint*(x, y: int): Point = Point(x: x, y: y)

proc lineToSegment*(line: string): Segment =
  let sp = splitWhitespace(line)

  proc commaPairToPoint(s: string): Point =
    let sp = split(s, ',')
    return nPoint(parseInt(sp[0]), parseInt(sp[1]))

  return Segment(
    p1: commaPairToPoint(sp[0]),
    # sp[1] is the '->'
    p2: commaPairToPoint(sp[2]),
  )


proc isHorizontal*(s: Segment): bool = s.p1.y == s.p2.y
proc isVertical*(s: Segment): bool = s.p1.x == s.p2.x

proc countSegment*(counts: var CountTable[(int, int)], s: Segment) =
  # the _much_ better way of doing this
  var dx = 1
  var dy = 1

  var x = s.p1.x
  var y = s.p1.y

  if s.p1.x == s.p2.x:
    dx = 0
  elif s.p1.x > s.p2.x:
    dx = -1

  if s.p1.y == s.p2.y:
    dy = 0
  elif s.p1.y > s.p2.y:
    dy = -1

  # add dx and dy to make the loop break AFTER all points in the line
  # have been added
  while (x, y) != (s.p2.x + dx, s.p2.y + dy):
    counts.inc((x, y))
    x += dx
    y += dy

proc day5*(filename: string): int =
  let segments: seq[Segment] = fileLinesToType[Segment](filename, lineToSegment)
  let hvFiltered: seq[Segment] = filter(segments, proc(s: Segment): bool = s.isVertical or s.isHorizontal)
  var overlapCounts = initCountTable[(int, int)]()

  for s in hvFiltered:
    countSegment(overlapCounts, s)

  var overlaps = 0
  for _, count in overlapCounts:
    if count > 1:
      overlaps += 1

  return overlaps

proc day5_2*(filename: string): int =
  let segments: seq[Segment] = fileLinesToType[Segment](filename, lineToSegment)
  var overlapCounts = initCountTable[(int, int)]()

  for s in segments:
    countSegment(overlapCounts, s)

  var overlaps = 0
  for _, count in overlapCounts:
    if count > 1:
      overlaps += 1

  return overlaps
