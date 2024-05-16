function explode(x, y, type)
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

  if type == "player" then
    sfx(1)
  else
    sfx(2)
  end

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

function final_flash_animation()
  local explx = flr(rnd(9))
  local exply = flr(rnd(9))
  camera_shake = 16

  if final_flash == 1 then
    explx = 4
    exply = 4
  end

  if t() % 1 == 0 then
    explode(final_flash_entity.x + flr(rnd(9)), final_flash_entity.y + flr(rnd(9)), "player")
    final_flash -= 1
    camera_shake = 3
  end

  if final_flash == 0 then
    del(entities, final_flash_entity)
  end
end