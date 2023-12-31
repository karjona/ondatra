move_table = { "straight", "bank", "turn", "advanced" }
orientation_table = { "right", "left" }

function calculateOffsets(angle)
  local a = angle % 360

  local offsetTable = {
    [0] = { y_offset = 8 },
    [45] = { x_offset = 5, y_offset = 5 },
    [90] = { x_offset = 8 },
    [135] = { x_offset = 5, y_offset = -5 },
    [180] = { y_offset = -8 },
    [225] = { x_offset = -5, y_offset = -5 },
    [270] = { x_offset = -8 },
    [315] = { x_offset = -5, y_offset = 5 }
  }

  return offsetTable[a] or {}
end

function calc_move_end_position(ship, move_type, speed, direction)
  local offsets = calculateOffsets(ship.angle)
  x_offset, y_offset = offsets.x_offset or 0, offsets.y_offset or 0

  if move_type == "straight" then
    return { x = ship.x + x_offset * speed, y = ship.y - speed * y_offset, angle = ship.angle }
  elseif move_type == "turn" then
    if direction == "right" then
      return { x = ship.x + x_offset * speed, y = ship.y - speed * y_offset, angle = ship.angle + 90 }
    else
      return { x = ship.x + x_offset * speed, y = ship.y - speed * y_offset, angle = ship.angle - 90 }
    end
  elseif move_type == "bank" then
    if direction == "right" then
      return { x = ship.x + x_offset * speed, y = ship.y - speed * y_offset, angle = ship.angle + 45 }
    else
      return { x = ship.x + x_offset * speed, y = ship.y - speed * y_offset, angle = ship.angle - 45 }
    end
  end
end

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
  local move_end = {}
  local offsets = calculateOffsets(ship.angle)
  x_offset, y_offset = offsets.x_offset or 0, offsets.y_offset or 0

  if type == "bank" then
    local spr_mapx = .5
    local spr_mapy = .5
    local arrow_x_offset = 0
    local arrow_y_offset = 0
    local arrow_angle = (360 - ship.angle + 270) % 360
    local angleOffsets = {}

    if speed == 1 then
      if move_orientation == 2 then
        spr_mapy = 3.5
      end

      -- lets calc the arrow offsets
      angleOffsets = {
        [0] = { [1] = { 7, 0 }, [2] = { -10, 0 } },
        [45] = { [1] = { 5, 7 }, [2] = { -7, -5 } },
        [90] = { [1] = { 0, 7 }, [2] = { 0, -10 } },
        [135] = { [1] = { -5, 7 }, [2] = { 7, -5 } },
        [180] = { [1] = { -7, 0 }, [2] = { 10, 0 } },
        [225] = { [1] = { -5, -7 }, [2] = { 7, 5 } },
        [270] = { [1] = { 0, -7 }, [2] = { 0, 10 } },
        [315] = { [1] = { 5, -7 }, [2] = { -7, 5 } }
      }
      arrow_x_offset, arrow_y_offset = unpack(angleOffsets[ship.angle % 360][move_orientation] or { 0, 0 })

      -- draw the arrow
      rspr(ship.x + arrow_x_offset, ship.y + arrow_y_offset, arrow_angle / 360, 9.5, spr_mapy, 3, true, 1)
    else
      if move_orientation == 1 then
        spr_mapx = 4.5
        spr_mapy = 4.5
      else
        spr_mapx = .5
        spr_mapy = 3.5
      end

      for i = 1, speed - 2 do
        rspr(ship.x + x_offset * i, ship.y - i * y_offset, ship.angle / 360, 4.5, .5, 1, false, 1)
      end

      -- lets calc the arrow offsets
      angleOffsets = {
        [0] = { { -1, 7 } },
        [45] = { { -5, 5 } },
        [90] = { { -7, -1 } },
        [135] = { { -5, -5 } },
        [180] = { { 1, -7 } },
        [225] = { { 5, -5 } },
        [270] = { { 7, 1 } },
        [315] = { { 5, 5 } }
      }
      arrow_x_offset, arrow_y_offset = unpack(angleOffsets[ship.angle % 360][1] or { 0, 0 })

      rspr(ship.x + x_offset * speed + arrow_x_offset, ship.y - speed * y_offset + arrow_y_offset, arrow_angle / 360, spr_mapx, spr_mapy, 3.5, true, 1)
    end
  end

  if type == "turn" then
    for i = 1, speed - 1 do
      rspr(ship.x + x_offset * i, ship.y - i * y_offset, ship.angle / 360, 4.5, .5, 1, false, 1)
    end
    if move_orientation == 1 then
      angle = ship.angle / 360
    else
      angle = -ship.angle / 360
    end

    if move_orientation == 1 then
      rspr(ship.x + x_offset * speed, ship.y - speed * y_offset, angle, 9.5, .5, 3, false, 1)
    else
      rspr(ship.x + x_offset * speed, ship.y - speed * y_offset, angle, 9.5, .5, 3.5, true, 1)
    end
  end

  if type == "straight" then
    for i = 1, speed - 1 do
      rspr(ship.x + x_offset * i, ship.y - i * y_offset, ship.angle / 360, 4.5, .5, 1, false, 1)
    end
    move_end = calc_move_end_position(ship, "straight", speed)
    rspr(move_end.x, move_end.y, ship.angle / 360, 2.5, .5, 1, false, 1)
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

function move_ship(ship, x, y, angle)
  ship.move_x = x
  ship.move_y = y
  ship.move_angle = angle

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

  ship.has_moved = true

  -- reset variables
  confirming_move = false
  selecting_move_menu_active = false
  selecting_move = nil
  selected_move_confirm_option = 1
  selected_move_option = 1
  move_speed = 1

  -- set battle state
  moving_ships = true
end

function animate_ship(ship)
  local moved = false
  if moving_ships and ship.dx != 0 then
    moved = true
    ship.x += ship.dx
    if ship.x == ship.move_x then
      ship.dx = 0
      ship.move_x = nil
    end
  end
  if moving_ships and ship.dy != 0 then
    moved = true
    ship.y += ship.dy
    if ship.y == ship.move_y then
      ship.dy = 0
      ship.move_y = nil
    end
  end
  if moving_ships and ship.dangle != 0 then
    moved = true
    ship.angle += ship.dangle
    if ship.angle == ship.move_angle then
      ship.dangle = 0
      ship.move_angle = nil
    end
  end

  return moved
end