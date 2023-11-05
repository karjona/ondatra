function create_ship(owner, model)
  if owner == nil then
    owner = "player"
  end

  if model == nil then
    model = "fighter"
  end

  local myship = {
    owner = owner,
    type = "ship",
    model = model,
    x = 15,
    y = 80,
    angle = 0,
    health = 100,
    max_health = 100,
    shield = 0,
    max_shield = 0,
    energy = 100,
    max_energy = 100
  }

  add(entities, myship)
end

function draw_ship(ship)
  local x = ship.x
  local y = ship.y
  local angle = ship.angle / 360
  local model = ship.model

  if model == "fighter" then
    rspr(x, y, angle, 0.5, 0.5, 1, 1)
  end
end