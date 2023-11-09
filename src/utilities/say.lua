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
  local startx = 1
  local starty = 86
  local width = 125
  local height = 21
  local padding = 2
  local portraitsize = 16
  local messagex = startx + portraitsize + padding * 2 + 1
  local messagey = starty + padding * 2 + 1

  local firstline = ""
  local secondline = ""

  if #radio > 0 then
    -- separate the message into two lines if needed
    -- only separate lines on spaces
    if #radio[1].message > 24 then
      local words = split(radio[1].message, " ")
      for i = 1, #words do
        if #firstline + #words[i] + 1 < 24 then
          firstline = firstline .. words[i] .. " "
        else
          secondline = secondline .. words[i] .. " "
        end
      end
    else
      -- if we only need one line
      firstline = radio[1].message
      messagey += 3
    end

    rectfillout(startx, starty, width, height)
    rect(startx + padding, starty + padding, startx + padding + portraitsize + 1, starty + padding + portraitsize + 1, 7) -- portrait box
    spr(1, startx + padding + 1, starty + padding + 1, 2, 2) -- portrait
    print(radio[1].actor, startx + padding, starty - 6) -- actor name
    print(firstline, messagex, messagey) -- message first line
    print(secondline, messagex, messagey + 6) -- message second line

    -- button indicator
    if t() % 1 < 0.5 then
      if radio[1].multipart then
        print("⬇️", startx + width - 6 - padding, starty + height + padding)
      else
        print("❎", startx + width - 6 - padding, starty + height + padding)
      end
    end
  end
end