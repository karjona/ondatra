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

  cards = {}
  card_pool = {}
  viewing_cards = false
  selected_card = 1

  selected_ship = nil
  selecting_move = nil
  selected_move_option = 1
  selecting_move_menu_active = false
  confirming_move = false
  confirming_orientation = false
  selected_move_confirm_option = 1
  move_speed = 1
  moving_ships = false
  move_target_arrow_pos = { x = nil, y = nil, angle = nil }

  selecting_target = nil
  shot_target = nil

  entities = {}

  -- initialize card pool
  init_cards()

  -- debug radio messages
  say("a.", "hello! this is a test radio message!", true)
  say("a.", "second radio message", true)
  say("a.", "ok, that's it. bye!")

  -- debug entities
  create_ship()
  create_ship("cpu", "creature")

  _upd = upd_battle
  _drw = drw_battle
end