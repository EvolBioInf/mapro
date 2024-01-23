!/^#/ {
  ts = $3
  split($5, arr, ",")
  ac = arr[1]
  st = tolower(ts)
  split(st, arr, " ")
  dir = substr(arr[1], 1, 1) substr(arr[2], 1, 2)
  printf("%s\t%s\t%s\n", dir, ac, ts)
}
