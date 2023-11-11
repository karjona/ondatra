move_table = { "straight", "bank", "turn", "advanced" }
orientation_table = { "right", "left" }

function draw_move_menu(ship)
  local x = 0
  local y = 0
  if selecting_move_menu_active then move_orientation = 1 end

  -- decide menu position
  if ship.x <= 64 then x = 68 else x = 10 end
  if ship.y <= 64 then y = 58 else y = 30 end

  -- draw the menu
  rectfillout(x, y, 50, 36)

  -- draw the text
  for i = 1, #move_table do
    print(move_table[i], x + 8, y + i * 8 - 8 + 4, 7)
  end

  -- draw the menu arrow
  if not selected_move_option then
    selected_move_option = 1
  end
  if selecting_move_menu_active then
    if t() % .5 < .25 then
      spr(84, x + 2, y + selected_move_option * 8 - 8 + 4, 1, 1)
    end
  end

  -- draw the movement arrow
  if t() % 2 < 1 and selecting_move_menu_active then
    move_orientation = 2
  end
  draw_arrow(ship, move_table[selected_move_option], move_speed)

  -- draw the speed
  -- draw the menu
  rectfillout(x, y + 40, 50, 10)

  -- draw the text
  rectfill(x + 2, y + 43, x + 6, y + 47, 3)
  print("speed: " .. move_speed .. "/" .. ship.max_speed, x + 8, y + 43, 7)
  if selecting_move_menu_active then
    print("⬅️➡️", x + 36, y + 52, 7)
  end
end

function draw_arrow(ship, type, speed)
  local x = ship.x + 50
  local y = ship.y - 50
  local turn_offset = 0

  if type == "bank" then
    local flip_first = false
    local flip_second = true

    if move_orientation == 2 then
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

    move_target_arrow_pos = { y = ship.y - speed * 8 }
    if move_orientation == 2 then
      move_target_arrow_pos.x = ship.x - 8
      move_target_arrow_pos.angle = ship.angle - 45
    else
      move_target_arrow_pos.x = ship.x + 8
      move_target_arrow_pos.angle = ship.angle + 45
    end
  end

  if type == "turn" then
    local arrow_angle = 0
    for i = 1, speed - 1 do
      spr(81, ship.x - 4, ship.y - 4 - i * 8)
    end
    if move_orientation == 1 then
      angle = 90 / 360
      turn_offset = 8
    else
      angle = 270 / 360
      turn_offset = -8
    end
    if move_orientation == 1 then
      spr(83, ship.x - 4, ship.y - 4 - speed * 8, 1, 1)
    else
      spr(83, ship.x - 4, ship.y - 4 - speed * 8, 1, 1, true)
    end
    rspr(ship.x + turn_offset, ship.y - speed * 8, angle, 2.5, .5, 1.4, false, 1)
    move_target_arrow_pos = { y = ship.y - speed * 8 }
    if move_orientation == 2 then
      move_target_arrow_pos.x = ship.x - 8
      move_target_arrow_pos.angle = ship.angle - 90
    else
      move_target_arrow_pos.x = ship.x + 8
      move_target_arrow_pos.angle = ship.angle + 90
    end
  end

  if type == "straight" then
    local x_offset = 0
    local y_offset = 0
    local angle = ship.angle % 360
    local scale = 1
    if angle == 45 then
      x_offset = 8
      y_offset = 8
      scale = 1.5
    elseif angle == 315 then
      x_offset = -8
      y_offset = 8
      scale = 1.5
    elseif angle == 90 then
      x_offset = 8
    elseif ship.angle == 270 then
      x_offset = -8
    elseif ship.angle == 180 then
      y_offset = -8
    elseif ship.angle == 0 then
      y_offset = 8
    end

    for i = 1, speed - 1 do
      rspr(ship.x + x_offset * i, ship.y - i * y_offset, ship.angle / 360, 4.5, .5, 1, false, scale)
    end
    rspr(ship.x + x_offset * speed, ship.y - speed * y_offset, ship.angle / 360, 2.5, .5, 1, false, scale)
    move_target_arrow_pos = { x = ship.x + x_offset * speed, y = ship.y - speed * y_offset, angle = ship.angle }
  end
end

function draw_move_confirm()
  local x = 39
  local y = 54

  -- draw the menu
  rectfillout(x, y, 50, 20)

  -- draw the text
  print("confirm", x + 8, y + 4, 7)
  print("cancel", x + 8, y + 12, 7)

  -- draw the menu arrow
  if not selected_move_confirm_option then
    selected_move_confirm_option = 1
  end
  if t() % .5 < .25 then
    spr(84, x + 2, y + selected_move_confirm_option * 8 - 8 + 4, 1, 1)
  end
end

function draw_move_orientation_select(ship)
  if ship.x <= 64 then x = 68 + 20 else x = 10 + 20 end
  if ship.y <= 64 then y = 58 + 24 else y = 30 + 24 end

  -- draw the menu
  rectfillout(x, y, 36, 20)

  -- draw the text
  for i = 1, #orientation_table do
    print(orientation_table[i], x + 8, y + i * 8 - 8 + 4, 7)
  end

  -- draw the menu arrow
  if not move_orientation then
    move_orientation = 1
  end
  if t() % .5 < .25 then
    spr(84, x + 2, y + move_orientation * 8 - 8 + 4, 1, 1)
  end
end

function move_ship()
  local ship = selecting_move
  local spd = move_speed
  local type = move_table[selected_move_option]

  if type == "straight" then
    ship.move_x = move_target_arrow_pos.x
    ship.move_y = move_target_arrow_pos.y
    ship.move_angle = move_target_arrow_pos.angle
  end

  if type == "bank" then
    ship.move_x = move_target_arrow_pos.x
    ship.move_y = move_target_arrow_pos.y
    ship.move_angle = move_target_arrow_pos.angle
  end

  if type == "turn" then
    ship.move_x = move_target_arrow_pos.x
    ship.move_y = move_target_arrow_pos.y
    ship.move_angle = move_target_arrow_pos.angle
  end

  -- set ship dx, dy, and dangle
  if ship.move_x > ship.x then
    ship.dx = .5
  elseif ship.move_x < ship.x then
    ship.dx = -.5
  end
  if ship.move_y > ship.y then
    ship.dy = .5
  elseif ship.move_y < ship.y then
    ship.dy = -.5
  end
  if ship.move_angle > ship.angle then
    ship.dangle = 1.5
  elseif ship.move_angle < ship.angle then
    ship.dangle = -1.5
  end

  -- reset variables
  confirming_move = false
  selecting_move_menu_active = false
  selecting_move = false
  selected_move_confirm_option = 1
  selected_move_option = 1
  move_speed = 1
  move_target_arrow_pos = { x = nil, y = nil, angle = nil }

  -- set battle state
  moving_ships = true
end