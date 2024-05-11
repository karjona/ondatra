function battle_button_x()
  if #radio > 0 then
    del_msg()
    return
  end

  if battle_phase == "movement" then
    -- if all moves menus are closed, open the main move menu
    if not selecting_move_menu_active
        and not confirming_orientation
        and not confirming_move then
      sfx(0)
      selecting_move = selected_ship
      selecting_move_menu_active = true
      return
    end

    -- if the main move menu is open, let the user interact with the moves
    if selecting_move_menu_active then
      -- open the confirmation or orientation menu depending on the move
      if move_table[selected_move_option] == "straight" then
        sfx(0)
        confirming_move = true
        selecting_move_menu_active = false
        return
      elseif move_table[selected_move_option] == "bank"
          or move_table[selected_move_option] == "turn" then
        sfx(0)
        confirming_orientation = true
        move_orientation = 1
        selecting_move_menu_active = false
        return
      elseif move_table[selected_move_option] == "advanced" then
        sfx(0)
        return
      end
    end

    -- if the move orientation menu is open, let the user interact with it
    if confirming_orientation then
      sfx(0)
      confirming_orientation = false
      confirming_move = true
      return
    end

    -- if the move confirmation menu is open, let the user interact with it
    if confirming_move then
      sfx(0)
      if selected_move_confirm_option == 1 then
        local move_end = {}
        -- select ok in confirm mode menu
        if move_table[selected_move_option] == "straight" then
          move_end = calc_move_end_position(selected_ship, "straight", move_speed)
        else
          move_end = calc_move_end_position(selected_ship, move_table[selected_move_option], move_speed, orientation_table[move_orientation])
        end
        move_ship(selected_ship, move_end.x, move_end.y, move_end.angle)
        return
      else
        -- selected cancel in confirm move menu
        confirming_move = false
        selecting_move_menu_active = true
        selected_move_confirm_option = 1
        return
      end
    end
  end

  if battle_phase == "shoot" then
    if not selecting_target then
      sfx(0)
      selecting_target = selected_ship
      return
    else
      if shot_target then
        shoot_ship(selecting_target, shot_target)
        selecting_target = nil
        shot_target = nil
      else
        -- no ships to shoot, pass the turn
        sfx(0)
        selecting_target.has_shot = true
        selecting_target = nil
      end
    end
  end
end

function battle_button_o()
  if #radio > 0 then
    del_msg()
    return
  end

  if battle_phase == "movement" then
    -- if the main move menu is open, close it
    if selecting_move_menu_active
        and not confirming_orientation
        and not confirming_move then
      sfx(0)
      selecting_move = nil
      selecting_move_menu_active = false
      selected_move_option = 1
      move_speed = 1
      return
    end

    -- if the move orientation menu is open, let the user interact with it
    if confirming_orientation then
      sfx(0)
      selecting_move_menu_active = true
      confirming_orientation = false
      return
    end

    -- if the move confirmation menu is open, let the user interact with it
    if confirming_move then
      sfx(0)
      selecting_move_menu_active = true
      confirming_move = false
      selected_move_confirm_option = 1
      return
    end
  end

  if battle_phase == "shoot" then
    sfx(0)
    selecting_target = nil
    shot_target = nil
    return
  end
end

function battle_button_up()
  if selecting_move_menu_active then
    change_move(-1)
    return
  end

  if confirming_orientation then
    change_orientation(-1)
    return
  end

  if confirming_move then
    change_move_confirm(-1)
    return
  end
end

function battle_button_down()
  if #radio > 0 then
    del_msg()
    return
  end

  if selecting_move_menu_active then
    change_move(1)
    return
  end

  if confirming_orientation then
    change_orientation(1)
    return
  end

  if confirming_move then
    change_move_confirm(1)
    return
  end
end

function battle_button_left()
  if selecting_move_menu_active then
    change_speed(-1)
    return
  end
end

function battle_button_right()
  if selecting_move_menu_active then
    change_speed(1)
    return
  end
end