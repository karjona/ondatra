function explode(x, y)
  -- add a big explosion centered on the entity
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

  -- add some smaller explosions
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

function shake_camera()
  local shakex = rnd(camera_shake) - camera_shake / 2
  local shakey = rnd(camera_shake) - camera_shake / 2

  camera(shakex, shakey)

  if camera_shake > 10 then
    camera_shake *= 0.9
  else
    camera_shake -= 1
  end

  if camera_shake < 1 then
    camera_shake = 0
  end
end