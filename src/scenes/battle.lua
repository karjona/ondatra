function upd_battle()
  if selected_card == nil then
    selected_card = 1
  end

  if #radio > 0 then
    if btnp(❎) then
      sfx(0)
      deli(radio, 1)
    end
  else
    -- no radio messages in queue
    if viewing_cards == false then
      -- map view
      if btnp(🅾️) then
        sfx(0)
        viewing_cards = true
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
        end
      end

      if btnp(➡️) then
        sfx(0)
        if selected_card < #cards then
          selected_card = selected_card + 1
        end
      end
    end
  end
end

function drw_battle()
  cls(1)

  -- draw cards
  for i = 1, #cards do
    local card = cards[i]
    local cardx = 10
    local cardy = 118

    if selected_card == i and viewing_cards then
      cardy = cardy - 52
    end

    if #cards >= 3 then
      -- to get the size of the dock where we put the cards
      -- we substract the margins and the width of the card
      -- from the screen width
      local docksize = 128 - cardx * 2 - cardw

      -- we divide the dock size by the number of cards
      -- minus one to get the gap between each card
      local gap = docksize / (#cards - 1)
      draw_card(card, cardx + i * gap - gap, cardy)
    elseif #cards == 2 then
      draw_card(card, cardx + i * 37 - 37, cardy)
    else
      draw_card(card, cardx, cardy)
    end
  end

  -- print radio messages
  print_radio()

  -- ui
  if #radio == 0 then
    if viewing_cards == false then
      print("🅾️ cards", 95, 1, 7)
    else
      print("🅾️ map", 95, 1, 7)
    end
  end
end