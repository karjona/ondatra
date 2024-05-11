function create_bullet(from, to)
  local speed = 2
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
    speed = speed,
    animation = { 96, 97, 98, 99, 98, 97 },
    frame = 1,
    animation_speed = 0.5
  }

  add(entities, mybullet)
end

function draw_bullet(bullet)
  bullet.frame += bullet.animation_speed
  if flr(bullet.frame) > #bullet.animation then
    bullet.frame = 1
  end
  spr(bullet.animation[flr(bullet.frame)], bullet.x, bullet.y, 1, 1)
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