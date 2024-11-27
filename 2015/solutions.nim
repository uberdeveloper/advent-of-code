import strutils

proc run(f:proc, filename: string): int=
  let input = readFile(filename)
  return f(input)

proc ex0101(input: string): int =
  var c = 0
  for i in input:
    if i == '(':
      c += 1
    elif i == ')':
      c -= 1
  return c

proc ex0102(input: string): int =
  var c = 0
  for i, t in input:
    if t == '(':
      c += 1
    elif t == ')':
      c -= 1
    if c < 0:
      return i+1
  return c

var res = run(ex0101, "data/ex01.txt")
echo "Solution to day 1 exercise 1 = ", res
res = run(ex0102, "data/ex01.txt")
echo "Solution to day 1 exercise 2 = ", res
