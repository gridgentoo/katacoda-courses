def fib(n):
  if n == 0:
    return 0
  elif n == 1:
    return 1
  else:
    return fib(n-1) + fib(n-2)

def values(event, context):
  row=[fib(n) for n in range(1,18)]
  print("Series created: " + row)
  return row
