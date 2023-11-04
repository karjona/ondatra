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
  if #radio > 0 then
    rect(32, 96, 96, 117, 7) -- outter box
    rect(34, 98, 51, 115, 7) -- portrait box
    print(radio[1].actor, 32, 90) -- actor name
    print(radio[1].message, 53, 100) -- message

    -- button indicator
    if t() % 1 < 0.5 then
      if radio[1].multipart then
        print("⬇️", 88, 110)
      else
        print("❎", 88, 110)
      end
    end
  end
end