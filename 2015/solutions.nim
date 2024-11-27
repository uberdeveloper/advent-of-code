import strutils, sequtils, math
import checksums/md5

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

proc ex0201(input: string): int =
  let sizes = input.splitlines()
  var c:int = 0
  var sz:seq[int]
  var arr:array[3, int]
  for s in sizes:
    try:
      if s.len > 0:
        sz = s.split('x').map(parseInt)
        arr[0] = sz[0] * sz[1]
        arr[1] = sz[1] * sz[2]
        arr[2] = sz[0] * sz[2]
        c += 2*sum(arr) + min(arr)
        #echo sz, " ", sum(arr), " ", min(arr), " ", c
    except EOFError:
      echo "End of file reached"
      break
  return c


proc ex0202(input: string): int =
  let sizes = input.splitlines()
  var c:int = 0
  var sz:seq[int]
  var arr:array[3, int]
  for s in sizes:
    try:
      if s.len > 0:
        sz = s.split('x').map(parseInt)
        arr[0] = sz[0] + sz[1]
        arr[1] = sz[1] + sz[2]
        arr[2] = sz[0] + sz[2]
        c += 2*min(arr) + (sz[0] * sz[1] * sz[2])
        #echo sz, " ", sum(arr), " ", min(arr), " ", c
    except EOFError:
      echo "End of file reached"
      break
  return c
    
proc ex0401(input: string): int=
  var txt = input
  var hashed: string
  for i in 0..100_000_000:
    hashed = getMD5(txt & $i)
    #echo hashed, " ", txt
    if hashed[0..4] == "00000":
      return i
  return 0

proc ex0402(input: string): int=
  var txt = input
  var hashed: string
  for i in 0..100_000_000:
    hashed = getMD5(txt & $i)
    #echo hashed, " ", txt
    if hashed[0..5] == "000000":
      return i
  return 0

proc ex0501(input: string): int=
  let strings = input.splitlines()
  var c:int = 0
  var length:int
  var vowel: bool = false
  var cons: bool = false
  var substr: bool = false
  var num_vowels:int = 0
  for s in strings:
    length = s.len
    for i in 0..length-2:
      if s[i] == s[i+1]:
        cons = true
    for ch in s:
      case ch:
        of 'a', 'e', 'i', 'o', 'u':
          num_vowels += 1
        else:
          discard
    for i in 0..length-2:
      case s[i..i+1]:
        of "ab", "cd", "pq", "xy":
          substr = true
        else:
          discard
    if num_vowels >= 3:
      vowel = true
    if cons and vowel and not substr:
      c += 1
    num_vowels = 0
    vowel = false
    cons = false
    substr = false 
  return c

var res:int
res = run(ex0101, "data/ex01.txt")
echo "Solution to day 1 exercise 1 = ", res
res = run(ex0102, "data/ex01.txt")
echo "Solution to day 1 exercise 2 = ", res
res = run(ex0201, "data/ex02.txt")
echo "Solution to day 2 exercise 1 = ", res
res = run(ex0202, "data/ex02.txt")
echo "Solution to day 2 exercise 2 = ", res
res = ex0401("yzbqklnj")
echo "Solution to day 4 exercise 1 = ", res
res = ex0402("yzbqklnj")
echo "Solution to day 4 exercise 2 = ", res
res = run(ex0501, "data/ex05.txt")
echo "Solution to day 5 exercise 1 = ", res
