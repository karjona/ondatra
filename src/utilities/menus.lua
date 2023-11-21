function change_speed(speed)
  sfx(0)

  -- speed can be 1 or -1 depending if we pressed the right or left keys
  -- we have to change it from values 1 to max_speed
  -- if it's 1 and we have speed -1, we have to change it to max_speed
  -- if it's max_speed and we have speed 1, we have to change it to 1
  move_speed = move_speed + speed
  if move_speed > selecting_move.max_speed then
    move_speed = 1
  elseif move_speed < 1 then
    move_speed = selecting_move.max_speed
  end
end

function change_move(direction)
  sfx(0)
  selected_move_option = (selected_move_option + direction - 1 + #move_table) % #move_table + 1
end

function change_orientation(direction)
  sfx(0)
  move_orientation = (move_orientation + direction - 1 + #orientation_table) % #orientation_table + 1
end

function change_move_confirm(direction)
  sfx(0)
  selected_move_confirm_option = (selected_move_confirm_option + direction - 1 + 2) % 2 + 1
end