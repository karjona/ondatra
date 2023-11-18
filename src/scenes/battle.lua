function upd_battle()
  -- update ship and game states

  -- we set the default battle phase to shoot
  -- if there's a ship yet to move, we set it to movement later
  battle_phase = "shoot"

  local ship_moved = false
  for entity in all(entities) do
    -- animate ship movement
    if entity.type == "ship" then
      if animate_ship(entity) then
        ship_moved = true
      end

      -- determine if we are on the movement phase
      if entity.has_moved == false then
        battle_phase = "movement"
      end

      if battle_phase == "shoot" then
        if entity.owner != "player" then
          local x1, y1, x2, y2 = calc_range_vertices(entities[1])
          if is_enemy_in_range(entity.x, entity.y, entities[1].x, entities[1].y, x1, y1, x2, y2) then
            entity.shot_target = true
          end
        end
      end
    end
  end
  if ship_moved then moving_ships = true else moving_ships = false end

  -- select the active ship
  select_ship()

  if selected_ship.owner != "player" then
    if battle_phase == "movement" then
      move_enemy(selected_ship)
    end
  end

  -- interaction

  if not moving_ships then
    if btnp(❎) then
      battle_button_x()
    end

    if btnp(🅾️) then
      battle_button_o()
    end

    if btnp(⬆️) then
      battle_button_up()
    end

    if btnp(⬇️) then
      battle_button_down()
    end

    if btnp(⬅️) then
      battle_button_left()
    end

    if btnp(➡️) then
      battle_button_right()
    end
  end
end

function drw_battle()
  draw_bg(level)
  print(battle_phase, 1, 1, 7)

  -- draw ships
  for entity in all(entities) do
    if entity.type == "ship" then
      draw_ship(entity)
      if entity.shot_target and not moving_ships then
        draw_shottarget(entity)
      end
    end
  end
  if selected_ship then draw_selsquare(selected_ship) end

  if battle_phase == "shoot" then
    -- draw shoot menu
  end

  -- draw move menu
  if battle_phase == "movement" then
    if selecting_move then
      draw_move_menu(selecting_move)
    end

    if confirming_orientation then
      draw_move_orientation_select(selecting_move)
    end

    if confirming_move then
      draw_move_confirm()
    end
  end

  -- draw cards
  for i = 1, #cards do
    local card = cards[i]
    local cardx = 10
    local targety = 118

    -- move selected card up
    if selected_card == i and viewing_cards then
      targety -= 52
    end

    -- animate cards
    if targety < card.y then
      card.spd = -4
    elseif targety > card.y then
      card.spd = 4
    elseif targety == card.y then
      card.spd = 0
    end
    card.y += card.spd

    if #cards >= 3 then
      -- to get the size of the dock where we put the cards
      -- we substract the margins and the width of the card
      -- from the screen width
      local docksize = 128 - cardx * 2 - cardw

      -- we divide the dock size by the number of cards
      -- minus one to get the gap between each card
      local gap = docksize / (#cards - 1)
      draw_card(card, cardx + i * gap - gap, card.y)
    elseif #cards == 2 then
      draw_card(card, cardx + i * 37 - 37, card.y)
    else
      draw_card(card, cardx, card.y)
    end
  end

  -- print radio messages
  print_radio()

  -- ui
  if #radio == 0 then
    if not moving_ships then
      if viewing_cards == false and not selecting_move then
        print("🅾️ cards", 91, 1, 7)
        if battle_phase == "movement" then
          print("❎ move", 91, 8, 7)
        elseif battle_phase == "shoot" then
          print("❎ shoot", 91, 8, 7)
        end
      elseif selecting_move then
        print("🅾️ cancel", 91, 1, 7)
        print("❎ ok", 91, 8, 7)
        print("⬆️⬇️ select", 83, 15, 7)
      else
        print("🅾️ map", 91, 1, 7)
        print("❎ play", 91, 8, 7)
        print("⬅️➡️ select", 83, 15, 7)
      end
    end
  end
end