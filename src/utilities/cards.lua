-- card properties
cardw = 40
cardh = 50

function create_card(card)
  local mycard = {
    title = card,
    cost = 1,
    rarity = 0,
    text = "shoot",
    img = 0,
    y = 118,
    spd = 0
  }

  add(cards, mycard)
end

function draw_card(card, x, y)
  local c = 6
  local txtc = 5

  -- draw the card
  rectfillout(x, y, cardw, cardh, c)

  -- fill with card properties
  print(card.title, x + 2, y + 2, txtc)
end