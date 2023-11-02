function say(actor, message)
  local radio_message = {
    actor = actor,
    message = message
  }

  add(radio, radio_message)
end

function print_radio()
  if #radio > 0 then
    rect(32, 96, 96, 114, 7)
  end
end