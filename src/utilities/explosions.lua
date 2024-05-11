function explode(x, y)
  for i = 1, 40 do
    local myexpl = {}
    myexpl.x = x
    myexpl.y = y
    myexpl.spd = (rnd() - 0.5) * 3
    myexpl.angle = (rnd() - 0.5) * 3.14
    myexpl.age = 20 + rnd(20)
    myexpl.color = 7
    myexpl.sx = cos(myexpl.angle) * myexpl.spd
    myexpl.sy = sin(myexpl.angle) * myexpl.spd
    add(particles, myexpl)
  end
end