function create_ship(owner, model)
  local x = 0
  local y = 0
  local selected = false

  if owner == nil then
    owner = "player"
  end

  if model == nil then
    model = "fighter"
    x = 32
    y = 64
    selected = true
  end

  if model == "creature" then
    x = rnd(128) + 8
    y = rnd(20) + 8
  end

  local myship = {
    owner = owner,
    type = "ship",
    model = model,
    selected = selected,
    has_moved = false,
    x = x,
    y = y,
    angle = 0,
    move_x = nil,
    move_y = nil,
    move_angle = nil,
    dx = 0,
    dy = 0,
    dangle = 0,
    health = 100,
    max_health = 100,
    shield = 0,
    max_shield = 0,
    energy = 100,
    max_energy = 100,
    max_speed = 4
  }

  add(entities, myship)
end

function draw_ship(ship)
  local x = ship.x
  local y = ship.y
  local spr_x = 0
  local spr_y = 0
  local angle = ship.angle / 360
  local model = ship.model

  if model == "fighter" then
    spr_x = .5
    spr_y = .5
    if t() % 5 >= 2 then
      y -= 1
    end
  elseif model == "creature" then
    spr_x = .5
    spr_y = 7.5
  end

  rspr(x, y, angle, spr_x, spr_y, 1, false, 1)
  if ship.has_moved and ship.owner == "player" then
    if battle_phase == "shoot" and not moving_ships then
      local x1, y1, x2, y2 = calc_range_vertices(ship)
      line(x, y, x1, y1, 8)
      line(x, y, x2, y2, 8)
    end
  end
end

function draw_selsquare(ship)
  local x = ship.x
  local y = ship.y

  if t() % 2 >= 0.5 then
    pal(7, 8)
  end

  spr(80, x - 5, y - 5, 1, 1)
  spr(80, x - 3, y - 5, 1, 1, true)
  spr(80, x - 5, y - 3, 1, 1, false, true)
  spr(80, x - 3, y - 3, 1, 1, true, true)
  pal()
end