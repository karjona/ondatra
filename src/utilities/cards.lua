-- card properties
cardw = 40
cardh = 50

function init_cards()
  local all_cards = {
    [1] = {
      title = "barrel roll",
      rarity = 1,
      text = "roll to the left or right"
    },
    [2] = {
      title = "u-turn",
      rarity = 1,
      text = "turn around"
    },
    [3] = {
      title = "missile",
      rarity = 2,
      text = "fire a missile"
    }
  }

  -- add all cards to the pool
  for card in all(all_cards) do
    create_card(card, true)
  end
end

function create_card(card, pool)
  if pool then
    local mycard = {
      title = card.title,
      rarity = card.rarity,
      text = card.text,
      y = 118,
      spd = 0
    }
    add(card_pool, mycard)
  else
    mycard = rnd(card_pool)
    local exists = false
    for existing_card in all(cards) do
      if existing_card.title == mycard.title then
        exists = true
        break
      end
    end

    if not exists then
      add(cards, mycard)
    end
  end
end

function draw_card(card, x, y)
  local c = 6
  local txtc = 5

  -- draw the card
  rectfillout(x, y, cardw, cardh, c)

  -- fill with card properties
  print(card.title, x + 2, y + 2, txtc)
end