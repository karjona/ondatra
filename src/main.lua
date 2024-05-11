-- set initial values
ver = "v1"
cartdata "karjona_ondatra"
starttime = t()
endtime = t()

function _init()
  endtime = t() + 0.2
  log("game started", true)
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
  level = 1
  radio = {}

  selected_ship = nil
  selecting_move = nil
  selected_move_option = 1
  selecting_move_menu_active = false
  confirming_move = false
  confirming_orientation = false
  selected_move_confirm_option = 1
  move_speed = 1
  moving_ships = false

  selecting_target = nil
  shot_target = nil

  entities = {}
  particles = {}

  -- debug radio messages
  say("a.", "hello! this is a test radio message!", true)
  say("a.", "second radio message", true)
  say("a.", "ok, that's it. bye!")

  -- debug entities
  create_ship()
  for i = 1, flr(rnd(5) + 1) do
    create_ship("cpu", "creature")
  end

  _upd = upd_battle
  _drw = drw_battle
end