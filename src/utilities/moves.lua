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

  spr(81, ship.x - 4, ship.y - 12)
  spr(81, ship.x - 4, ship.y - 20)
  spr(82, ship.x - 4, ship.y - 28)
end