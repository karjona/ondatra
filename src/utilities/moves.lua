move_table = { "straight", "bank", "turn", "advanced" }

function draw_move_menu(ship)
  local x = ship.x + 50
  local y = ship.y - 50
  local c = 0
  local outc = 7
  local orientation = "left"

  -- draw the menu
  rectfillout(x, y, 50, 36, c, outc)

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
  draw_arrow(ship, move_table[selected_move_option], move_speed, orientation)

  -- draw the speed
  -- draw the menu
  rectfillout(x, y + 40, 50, 10, c, outc)

  -- draw the text
  rectfill(x + 2, y + 43, x + 6, y + 47, 3)
  print("speed: " .. move_speed .. "/" .. ship.max_speed, x + 8, y + 43, outc)
  print("⬅️➡️", x + 36, y + 52, outc)
end

function draw_arrow(ship, type, speed, orientation)
  local x = ship.x + 50
  local y = ship.y - 50
  local turn_offset = 0

  if type == "bank" then
    local flip_first = false
    local flip_second = true

    if orientation == "right" then
      flip_first = true
      turn_offset = -16
      flip_second = false
    end

    if speed >= 2 then
      for i = 1, speed - 2 do
        spr(81, ship.x - 4, ship.y - 4 - i * 8)
      end
      spr(83, ship.x - 4, ship.y - speed * 8 + 4, 1, 1, flip_first)
      spr(83, ship.x + 4 + turn_offset, ship.y - speed * 8 + 4, 1, 1, flip_second, true)
      spr(82, ship.x + 4 + turn_offset, ship.y - speed * 8 - 4)
    else
      spr(83, ship.x + 4 + turn_offset, ship.y - speed * 8 + 4, 1, 1, flip_second, true)
      spr(82, ship.x + 4 + turn_offset, ship.y - speed * 8 - 4)
    end
  end

  if type == "turn" then
    for i = 1, speed - 1 do
      spr(81, ship.x - 4, ship.y - 4 - i * 8)
    end
    if orientation == "left" then
      angle = 90 / 360
      turn_offset = 8
    else
      angle = 270 / 360
      turn_offset = -8
    end
    if orientation == "left" then
      spr(83, ship.x - 4, ship.y - 4 - speed * 8, 1, 1)
    else
      spr(83, ship.x - 4, ship.y - 4 - speed * 8, 1, 1, true)
    end
    rspr(ship.x + turn_offset, ship.y - speed * 8, angle, 2.5, .5, 1.4, false, 1)
  end

  if type == "straight" then
    for i = 1, speed - 1 do
      spr(81, ship.x - 4, ship.y - 4 - i * 8)
    end
    spr(82, ship.x - 4, ship.y - 4 - speed * 8)
  end
end