function upd_battle()
  if selected_card == nil then
    selected_card = 1
  end

  if #radio > 0 then
    if btnp(❎) or btnp(🅾️) or btnp(⬇️) then
      sfx(0)
      deli(radio, 1)
    end
  else
    -- no radio messages in queue
    if viewing_cards == false then
      -- map view
      if btnp(🅾️) and selecting_move == false then
        sfx(0)
        viewing_cards = true
      end
      if btnp(❎) and selecting_move == false then
        for entity in all(entities) do
          if entity.selected then
            if entity.type == "ship" then
              sfx(0)
              selecting_move = entity
            end
          end
        end
      end
      -- select move menu
      if btnp(🅾️) and selecting_move then
        sfx(0)
        selecting_move = false
      end
      if btnp(⬇️) and selecting_move then
        sfx(0)
        if selected_move_option < 4 then
          selected_move_option += 1
        else
          selected_move_option = 1
        end
      end
      if btnp(⬆️) and selecting_move then
        sfx(0)
        if selected_move_option > 1 then
          selected_move_option -= 1
        else
          selected_move_option = 4
        end
      end
      if btnp(➡️) and selecting_move then
        sfx(0)
        if move_speed >= selecting_move.max_speed then
          move_speed = 1
        else
          move_speed += 1
        end
      end
      if btnp(⬅️) and selecting_move then
        sfx(0)
        if move_speed <= 1 then
          move_speed = selecting_move.max_speed
        else
          move_speed -= 1
        end
      end
    else
      -- card screen
      if btnp(🅾️) then
        sfx(0)
        viewing_cards = false
      end

      if btnp(⬅️) then
        sfx(0)
        if selected_card > 1 then
          selected_card = selected_card - 1
        else
          selected_card = #cards
        end
      end

      if btnp(➡️) then
        sfx(0)
        if selected_card < #cards then
          selected_card = selected_card + 1
        else
          selected_card = 1
        end
      end
    end
  end
end

function drw_battle()
  draw_bg(level)

  -- draw ships
  for entity in all(entities) do
    if entity.type == "ship" then
      draw_ship(entity)
      if entity.selected then
        draw_selsquare(entity)
      end
    end
  end

  -- draw move menu
  if selecting_move then
    draw_move_menu(selecting_move)
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
    if viewing_cards == false and not selecting_move then
      print("🅾️ cards", 91, 1, 7)
      print("❎ move", 91, 8, 7)
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