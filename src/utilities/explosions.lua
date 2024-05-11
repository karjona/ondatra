function explode(x, y)
  local myexpl = {}
  myexpl.x = x
  myexpl.y = y
  myexpl.age = 0
  myexpl.maxage = 0
  myexpl.color = 7
  myexpl.size = 8
  myexpl.sx = 0
  myexpl.sy = 0
  add(particles, myexpl)

  for i = 1, 20 do
    local myexpl = {}
    myexpl.x = x
    myexpl.y = y
    myexpl.spd = (rnd() - 0.5) * 6
    myexpl.angle = (rnd() - 0.5) * 3.14
    myexpl.maxage = 10 + rnd(10)
    myexpl.age = rnd(2)
    myexpl.color = 7
    myexpl.size = rnd(4) + 1
    myexpl.sx = cos(myexpl.angle) * myexpl.spd
    myexpl.sy = sin(myexpl.angle) * myexpl.spd
    add(particles, myexpl)
  end
end