function create_ship(owner, model)
  local x = 0
  local y = 0
  local angle = 0
  local initiative = 40
  local has_moved = false

  if owner == nil then
    owner = "player"
  end

  if model == nil then
    model = "fighter"
    x = 48
    y = 64
  end

  if model == "creature" then
    x = 32
    y = 24
    initiative = 20
    angle = 90
  end

  local myship = {
    owner = owner,
    type = "ship",
    model = model,
    initiative = initiative,
    has_moved = has_moved,
    has_shot = false,
    x = x,
    y = y,
    angle = angle,
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
    max_speed = 4,
    max_range = 4
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
end

function draw_rangelines(ship)
  local x1, y1, x2, y2 = calc_range_vertices(ship.x, ship.y, ship.max_range, ship.angle)
  line(ship.x, ship.y, x1, y1, 8)
  line(ship.x, ship.y, x2, y2, 8)
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

function draw_shottarget(ship)
  local x = ship.x
  local y = ship.y

  local frame = flr(t() / 0.1) % 4
  local sprite = frame == 3 and 90 or 89 + frame

  spr(sprite, x - 4, y - 10)
end

function select_ship()
  local highest_initiative = 0
  for entity in all(entities) do
    if battle_phase == "movement" then
      if entity.type == "ship" and entity.has_moved == false then
        if entity.initiative > highest_initiative then
          highest_initiative = entity.initiative
          selected_ship = entity
        end
      end
    elseif battle_phase == "shoot" then
      if entity.type == "ship" and entity.has_shot == false then
        if entity.initiative > highest_initiative then
          highest_initiative = entity.initiative
          selected_ship = entity
        end
      end
    end
  end
end