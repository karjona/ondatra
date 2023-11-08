move_table = { "straight", "bank", "turn", "advanced" }

function draw_move_menu(ship)
  local x = ship.x + 50
  local y = ship.y - 50
  local c = 0
  local outc = 7
  local orientation = "left"

  -- draw the menu
  rectfill(x, y, x + 50, y + 46, c)

  -- draw the outline
  rect(x, y, x + 50, y, outc)
  rect(x, y + 36, x + 50, y + 36, outc)
  rect(x, y, x, y + 36, outc)
  rect(x + 50, y, x + 50, y + 36, outc)

  -- draw the text
  for i = 1, #move_table do
    print(move_table[i], x + 8, y + i * 8 - 8 + 4, outc)
  end

  -- draw the arrow
  if not selected_move_option then
    selected_move_option = 1
  end
  if t() % .5 < .25 then
    spr(84, x + 2, y + selected_move_option * 8 - 8 + 4, 1, 1)
  end
  if t() % 2 < 1 then
    orientation = "right"
  end
  draw_arrow(ship, move_table[selected_move_option], 3, orientation)
end

function draw_arrow(ship, type, speed, orientation)
  local x = ship.x + 50
  local y = ship.y - 50
  local angle = 0
  local turn_offset = 0

  if type == "bank" then
    if orientation == "left" then
      angle = 45 / 360
      turn_offset = 5
    else
      angle = 315 / 360
      turn_offset = -6
    end

    for i = 1, speed do
      rspr(ship.x, ship.y - i * 8, angle, 4.5, .5, 1, false, 1)
    end
    rspr(ship.x + turn_offset, ship.y - 4 - speed * 8, angle, 2.5, .5, 2, false, 1)
  end

  if type == "turn" then
    for i = 1, speed do
      spr(81, ship.x - 4, ship.y - 4 - i * 8)
    end
    if orientation == "left" then
      angle = 90 / 360
      turn_offset = 7
    else
      angle = 270 / 360
      turn_offset = -8
    end
    if orientation == "left" then
      spr(83, ship.x - 4, ship.y - 8 - speed * 8, 1, 1)
    else
      spr(83, ship.x - 4, ship.y - 8 - speed * 8, 1, 1, true)
    end
    rspr(ship.x + turn_offset, ship.y - speed * 8 - 4, angle, 2.5, .5, 1.4, false, 1)
  end

  if type == "straight" then
    for i = 1, speed do
      spr(81, ship.x - 4, ship.y - 4 - i * 8)
    end
    spr(82, ship.x - 4, ship.y - 12 - speed * 8)
  end
end