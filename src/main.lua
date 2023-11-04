-- set initial values
ver = "v1"
cartdata "karjona_ondatra"
starttime = t()
endtime = t()

function _init()
  endtime = t() + 0.2
  _drw = drw_logo
  _upd = upd_logo
end

function _update60()
  _upd()
end

function _draw()
  _drw()
  camera()
end

function start_game()
  radio = {}
  cards = {}

  -- debug radio messages
  say("a.", "hello! this is a test radio message!", true)
  say("a.", "second radio message", true)
  say("a.", "ok, that's it. bye!")

  _upd = upd_battle
  _drw = drw_battle
end