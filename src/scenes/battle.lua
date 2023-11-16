function upd_battle()
  if selected_card == nil then
    selected_card = 1
  end

  battle_phase = "shoot"
  for entity in all(entities) do
    if entity.type == "ship" and entity.owner == "player" then
      if entity.has_moved == false then
        battle_phase = "movement"
        break
      end
    end

    if entity.type == "ship" and entity.owner != "player" then
      local x1, y1, x2, y2 = calc_range_vertices(entities[1])
      if is_enemy_in_range(entity.x, entity.y, entities[1].x, entities[1].y, x1, y1, x2, y2) then
        entity.selected = true
      end
    end
  end

  if #radio > 0 then
    if btnp(❎) or btnp(🅾️) or btnp(⬇️) then
      sfx(0)
      deli(radio, 1)
      return
    end
  else
    if not moving_ships then
      -- no radio messages in queue
      if viewing_cards == false then
        -- map view
        if btnp(🅾️) and selecting_move == false then
          sfx(0)
          viewing_cards = true
          return
        end
        if btnp(❎) and selecting_move == false then
          for entity in all(entities) do
            if entity.selected then
              if entity.type == "ship" then
                sfx(0)
                selecting_move = entity
                selecting_move_menu_active = true
                return
              end
            end
          end
        end
        -- select move menu
        if btnp(🅾️) and selecting_move_menu_active then
          sfx(0)
          selecting_move = false
          selecting_move_menu_active = false
          selected_move_option = 1
          move_speed = 1
          return
        end
        if btnp(⬇️) and selecting_move_menu_active then
          sfx(0)
          if selected_move_option < 4 then
            selected_move_option += 1
            return
          else
            selected_move_option = 1
            return
          end
        end
        if btnp(⬆️) and selecting_move_menu_active then
          sfx(0)
          if selected_move_option > 1 then
            selected_move_option -= 1
            return
          else
            selected_move_option = 4
            return
          end
        end
        if btnp(➡️) and selecting_move_menu_active then
          sfx(0)
          if move_speed >= selecting_move.max_speed then
            move_speed = 1
            return
          else
            move_speed += 1
            return
          end
        end
        if btnp(⬅️) and selecting_move_menu_active then
          sfx(0)
          if move_speed <= 1 then
            move_speed = selecting_move.max_speed
            return
          else
            move_speed -= 1
            return
          end
        end
        if btnp(❎) and selecting_move_menu_active then
          if move_table[selected_move_option] == "straight" then
            -- straight: show confirm move
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
          end
        end

        -- confirm move orientation
        if btnp(❎) and confirming_orientation then
          sfx(0)
          confirming_orientation = false
          confirming_move = true
          return
        end
        if btnp(🅾️) and confirming_orientation then
          sfx(0)
          selecting_move_menu_active = true
          confirming_orientation = false
          return
        end
        if (btnp(⬆️) or btnp(⬇️)) and confirming_orientation then
          sfx(0)
          if move_orientation == 1 then
            move_orientation = 2
            return
          else
            move_orientation = 1
            return
          end
        end

        -- confirm move dialog
        if btnp(❎) and confirming_move then
          sfx(0)
          if selected_move_confirm_option == 1 then
            -- select ok in confirm mode menu
            move_ship(selecting_move)
            return
          else
            -- selected cancel in confirm move menu
            confirming_move = false
            selecting_move_menu_active = true
            selected_move_confirm_option = 1
          end
        end
        if btnp(🅾️) and confirming_move then
          sfx(0)
          selecting_move_menu_active = true
          confirming_move = false
          selected_move_confirm_option = 1
          return
        end
        if btnp(⬇️) and confirming_move then
          sfx(0)
          if selected_move_confirm_option < 2 then
            selected_move_confirm_option += 1
            return
          else
            selected_move_confirm_option = 1
            return
          end
        end
        if btnp(⬆️) and confirming_move then
          sfx(0)
          if selected_move_confirm_option > 1 then
            selected_move_confirm_option -= 1
            return
          else
            selected_move_confirm_option = 2
            return
          end
        end
      else
        -- card screen
        if btnp(🅾️) then
          sfx(0)
          viewing_cards = false
          return
        end

        if btnp(⬅️) then
          sfx(0)
          if selected_card > 1 then
            selected_card = selected_card - 1
            return
          else
            selected_card = #cards
            return
          end
        end

        if btnp(➡️) then
          sfx(0)
          if selected_card < #cards then
            selected_card = selected_card + 1
            return
          else
            selected_card = 1
            return
          end
        end
      end
    end
  end
end

function drw_battle()
  local ship_moved = false
  local selected_ship = nil
  draw_bg(level)

  -- draw and animate ships
  for entity in all(entities) do
    if entity.type == "ship" then
      draw_ship(entity)
      if entity.selected and not moving_ships then
        draw_selsquare(entity)
        selected_ship = entity
      end
      if moving_ships and entity.dx != 0 then
        ship_moved = true
        entity.x += entity.dx
        if entity.x == entity.move_x then
          entity.dx = 0
          entity.move_x = nil
        end
      end
      if moving_ships and entity.dy != 0 then
        ship_moved = true
        entity.y += entity.dy
        if entity.y == entity.move_y then
          entity.dy = 0
          entity.move_y = nil
        end
      end
      if moving_ships and entity.dangle != 0 then
        ship_moved = true
        entity.angle += entity.dangle
        if entity.angle == entity.move_angle then
          entity.dangle = 0
          entity.move_angle = nil
        end
      end
    end
  end

  if battle_phase == "shoot" then
    -- draw shoot menu
  end

  -- draw move menu
  if selecting_move then
    draw_move_menu(selecting_move)
  end

  if confirming_orientation then
    draw_move_orientation_select(selecting_move)
  end

  if confirming_move then
    draw_move_confirm()
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

  if not ship_moved then moving_ships = false end
end