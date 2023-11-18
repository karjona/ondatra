function create_bullet(from, to)
  local speed = 1
  local type = "bullet"

  local mybullet = {
    x = flr(from.x),
    y = flr(from.y),
    tx = flr(to.x),
    ty = flr(to.y),
    target = to,
    type = type,
    speed = speed
  }

  add(entities, mybullet)
end

function draw_bullet(bullet)
  circfill(bullet.x, bullet.y, 3, 8)
end