function say(actor, message, multipart)
  if multipart == nil then
    multipart = false
  end

  local radio_message = {
    actor = actor,
    message = message,
    multipart = multipart
  }

  add(radio, radio_message)
end

function print_radio()
  local startx = 32
  local starty = 96
  local width = 64
  local height = 21
  local padding = 2
  local portraits = 16
  local messagex = startx + portraits + padding * 2 + 1
  local messagey = starty + padding * 2 + 1

  if #radio > 0 then
    rect(startx, starty, startx + width, starty + height, 7) -- outter box
    rect(startx + padding, starty + padding, startx + padding + portraits + 1, starty + padding + portraits + 1, 7) -- portrait box
    print(radio[1].actor, startx, starty - 6) -- actor name
    print(radio[1].message, messagex, messagey) -- message
    print("text test", messagex, messagey + 6) -- message second line
    spr(1, 35, 99, 2, 2) -- portrait

    -- button indicator
    if t() % 1 < 0.5 then
      if radio[1].multipart then
        print("⬇️", 90, 119)
      else
        print("❎", 90, 119)
      end
    end
  end
end