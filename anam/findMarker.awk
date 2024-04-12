{
  n2 = $1
  p2 = $2
  s2 = $3
  if(n1==n2 && s1 != s2) {
    print n1, p1, p2
    exit
  }
  n1 = n2
  s1 = s2
  p1 = p2
}
