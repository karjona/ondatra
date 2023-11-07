function draw_move_menu(ship)
  local x = ship.x + 50
  local y = ship.y - 50
  local c = 0
  local outc = 7

  -- draw the menu
  rectfill(x, y, x + 50, y + 40, c)

  -- draw the outline
  rect(x, y, x + 50, y, outc)
  rect(x, y + 40, x + 50, y + 40, outc)
  rect(x, y, x, y + 40, outc)
  rect(x + 50, y, x + 50, y + 40, outc)
end

function draw_arrow(ship)
  local x = ship.x + 50
  local y = ship.y - 50

  -- 45 degree arrow
  --spr(81, ship.x - 4, ship.y - 12)
  --spr(84, ship.x - 4, ship.y - 20, 1, 1, true)
  --rspr(ship.x + 2, ship.y - 16, 45 / 360, 2.5, .5, 1, false, 1)

  -- 90 degree arrow
  --spr(81, ship.x - 4, ship.y - 12)
  --spr(83, ship.x - 4, ship.y - 20, 1, 1)
  --rspr(ship.x + 7, ship.y - 16, 90 / 360, 2.5, .5, 1, false, 1)

  -- straight arrow
  spr(81, ship.x - 4, ship.y - 12)
  spr(81, ship.x - 4, ship.y - 20)
  spr(82, ship.x - 4, ship.y - 28)
end