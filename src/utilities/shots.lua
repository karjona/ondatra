function is_enemy_in_range(enx, eny, shipx, shipy, x2, y2, x3, y3)
  local den = (y2 - y3) * (shipx - x3) + (x3 - x2) * (shipy - y3)
  local a = ((y2 - y3) * (enx - x3) + (x3 - x2) * (eny - y3)) / den
  local b = ((y3 - shipy) * (enx - x3) + (shipx - x3) * (eny - y3)) / den
  local c = 1 - a - b

  return a >= 0 and a <= 1 and b >= 0 and b <= 1 and c >= 0 and c <= 1
end

function normalize_angle(angle)
  -- for pico8, angle 0 is ship aiming to the right
  -- for us, angle 0 is ship aiming up
  -- convert to pico8 angle by substracting a full
  -- counter-clockwise rotation + 90 degrees
  local normalized_angle = (450 - angle) % 360
  return normalized_angle
end

function calc_range_vertices(ship)
  local x = ship.x
  local y = ship.y
  local range = ship.max_range * 8

  local angle = normalize_angle(ship.angle)

  local a1 = (angle % 360 - 45) / 360
  local a2 = (angle % 360 + 45) / 360

  local x1 = range * cos(a1) + x
  local y1 = range * sin(a1) + y
  local x2 = range * cos(a2) + x
  local y2 = range * sin(a2) + y

  return x1, y1, x2, y2
end

function shoot_ship(from, to)
  create_bullet(from, to)
  from.has_shot = true
end