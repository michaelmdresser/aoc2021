import sequtils
import strutils

import util

type
  Point* = object
    x*, y*: int

  Segment* = object
    p1*, p2*: Point

proc nPoint*(x, y: int): Point = Point(x: x, y: y)

proc `*`* (x: int, p: Point): Point = nPoint(p.x * x, p.y * x)
proc `+`* (p1: Point, p2: Point): Point = nPoint(p1.x + p2.x, p1.y + p2.y)
proc `-`* (p1, p2: Point): Point = nPoint(p1.x - p2.x, p1.y - p2.y)
# proc `/`* (p: Point, x: int): Point = nPoint(p.x / x, p.y / x)

# 2d vector cross-product
proc `*`* (v, w: Point): int = (v.x * w.y) - (v.y * w.x)

# 2d vector dot-product
proc dot* (v, w: Point): int = (v.x * w.x) + (v.y * w.y)

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

proc colinear(s1, s2: Segment): bool =
  let p = s1.p1
  let r = s1.p2 - p
  let q = s2.p1
  let s = s2.p2 - q
  return ((r * s) == 0) and (((q - p) * r) == 0)


proc one_d_intervals_intersect(a1, a2, b1, b2: int): bool =
  # https://scicomp.stackexchange.com/questions/26258/the-easiest-way-to-find-intersection-of-two-intervals
  return (a2 >= b1) and (b2 >= a1)

# so I wrote this whole thing out but I don't think its actually useful
# for part 1 (haven't seen part 2 yet) because we're on an integer grid
# and need # of overlapping points
# proc intersects*(s1, s2: Segment): bool =
#   # https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
#   let p = s1.p1
#   let r = s1.p2 - p
#   let q = s2.p1
#   let s = s2.p2 - q

#   let t = (q - p) * (s / (r * s))
#   let u = (p - q) * (r / (s * r))
#   # alternate definition to save computation steps
#   # I'm not sure if the nim compiler can optimize this, so I'll
#   # leave it alone for now
#   # let u = (q - p) * (r / (r * s))

#   if colinear(s1, s2):
#     let t0 = (q - p) . (r / (r . r))
#     let t1 = (q + s - p) . (r / (r . r))

#     if t1 >= t0:
#       return one_d_intervals_intersect(t0, t1, 0, 1)
#     else:
#       return one_d_intervals_intersect(t1, t0, 0, 1)

#   if (r * s) == 0 and (0 <= t and t <= 1) and (0 <= u and u <= 1):
#     # let meeting_point = p * (t * r)
#     return true

#   return false



proc markGridWithSegment*(grid: seq[seq[int]], s: Segment): seq[seq[int]] =
  var grid = grid

  if s.isHorizontal or s.isVertical:
    for x in countup(min(s.p1.x, s.p2.x), max(s.p1.x, s.p2.x)):
      for y in countup(min(s.p1.y, s.p2.y), max(s.p1.y, s.p2.y)):
        grid[x][y] += 1
  else:
    let min_x = min(s.p1.x, s.p2.x)
    let min_y = min(s.p1.y, s.p2.y)

    # this is overly complex due to the diagonal constraint
    # it could just be abs(s.p1.x - s.p2.x)
    let steps = max(abs(s.p1.x - s.p2.x), abs(s.p1.y - s.p2.y))

    if s.p2.x >= s.p1.x and s.p2.y >= s.p1.y:
      for step in 0..steps:
        grid[s.p1.x + step][s.p1.y + step] += 1
    elif s.p2.x >= s.p1.x and s.p2.y < s.p1.y:
      for step in 0..steps:
        grid[s.p1.x + step][s.p1.y - step] += 1
    elif s.p2.x < s.p1.x and s.p2.y >= s.p1.y:
      for step in 0..steps:
        grid[s.p1.x - step][s.p1.y + step] += 1
    elif s.p2.x < s.p1.x and s.p2.y < s.p1.y:
      for step in 0..steps:
        grid[s.p1.x - step][s.p1.y - step] += 1

  return grid

proc transpose*(g: seq[seq[int]]): seq[seq[int]] =
  result = repeat(repeat(0, g.len), g[0].len)
  for x in 0..<g.len:
    for y in 0..<g[x].len:
      result[y][x] = g[x][y]

proc pretty*(grid: seq[seq[int]]): string =
  var s = ""
  for row in transpose(grid):
    for overlaps in row:
      if overlaps > 0:
        s.add($overlaps)
      else:
        s.add(".")

    s.add("\n")

  return s

proc day5*(filename: string): int =
  let segments: seq[Segment] = fileLinesToType[Segment](filename, lineToSegment)
  let hvFiltered: seq[Segment] = filter(segments, proc(s: Segment): bool = s.isVertical or s.isHorizontal)

  var max_x = 0
  var max_y = 0
  for seg in hvFiltered:
    max_x = max(max(max_x, seg.p1.x), seg.p2.x)
    max_y = max(max(max_y, seg.p1.y), seg.p2.y)

  # +1 because the max should be a viable index
  var overlappingGrid: seq[seq[int]] = repeat(repeat(0, max_y + 1), max_x + 1)

  for s in hvFiltered:
    overlappingGrid = markGridWithSegment(overlappingGrid, s)

  var overlaps = 0
  for x in 0..<overlappingGrid.len:
    for y in 0..<overlappingGrid[x].len:
      if overlappingGrid[x][y] > 1:
        overlaps += 1

  return overlaps

proc day5_2*(filename: string): int =
  let segments: seq[Segment] = fileLinesToType[Segment](filename, lineToSegment)

  var max_x = 0
  var max_y = 0
  for seg in segments:
    max_x = max(max(max_x, seg.p1.x), seg.p2.x)
    max_y = max(max(max_y, seg.p1.y), seg.p2.y)

  # +1 because the max should be a viable index
  var overlappingGrid: seq[seq[int]] = repeat(repeat(0, max_y + 1), max_x + 1)

  for s in segments:
    overlappingGrid = markGridWithSegment(overlappingGrid, s)

  # echo "grid"
  # for row in overlappingGrid:
  #   echo row

  var overlaps = 0
  for x in 0..<overlappingGrid.len:
    for y in 0..<overlappingGrid[x].len:
      if overlappingGrid[x][y] > 1:
        overlaps += 1

  return overlaps
