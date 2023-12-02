function create_bullet(from, to)
  local speed = 1
  local type = "bullet"

  local angle = atan2(to.y - from.y, to.x - from.x)

  local mybullet = {
    x = from.x,
    y = from.y,
    tx = to.x,
    ty = to.y,
    sx = sin(angle) * speed,
    sy = cos(angle) * speed,
    target = to,
    type = type,
    speed = speed
  }

  add(entities, mybullet)
end

function draw_bullet(bullet)
  circfill(bullet.x, bullet.y, 3, 8)
end

function collide(ax, ay, aw, ah, bx, by, bw, bh)
  local a_left = ax
  local a_top = ay
  local a_right = ax + aw - 1
  local a_bottom = ay + ah - 1

  local b_left = bx
  local b_top = by
  local b_right = bx + bw - 1
  local b_bottom = by + bh - 1

  if a_top > b_bottom then return false end
  if b_top > a_bottom then return false end
  if a_left > b_right then return false end
  if b_left > a_right then return false end

  return true
end