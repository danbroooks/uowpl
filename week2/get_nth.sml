
fun get_nth(items : 'a list, n : int) : 'a =
  if n = 1
  then hd items
  else get_nth(tl items, n - 1)

