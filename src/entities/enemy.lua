function move_enemy(ship)
  if t() % 2 == 0 then
    search_player_ship(ship)
    log("enemy moved")
  end
end

function shoot_enemy(ship)
  log("enemy shoot!")
  ship.has_shot = true
end

function search_player_ship(ship)
  -- the goal of this function is to see if there are player
  -- ships in range of this enemy ship

  -- player ships are in range when these conditions are met:
  -- distance from enemy ship is <= 48
  -- angle from enemy ship is +- 45 degrees

  -- get all player ships
  local player_ships = get_player_ships()

  -- for each player ship, check if it is in range
  for i, player_ship in ipairs(player_ships) do
    -- get distance from enemy ship to player ship
    log("player ship: " .. player_ship.x .. ", " .. player_ship.y)
    local distance = get_distance(ship, player_ship)
    if distance <= 36 then
      log("player ship in range: " .. distance)
      -- check if in correct angle
      local x1, y1, x2, y2 = calc_range_vertices(ship)
      if is_enemy_in_range(player_ship.x, player_ship.y, ship.x, ship.y, x1, y1, x2, y2) then
        log("player ship in correct angle")
      else
        log("player ship not in correct angle")
      end
    elseif distance <= 70 then
      log("not in range but potentially in range if moving towards it")
    end
  end

  log("moving speed 1 straight")
  local move_end = calc_move_end_position(ship, "straight", 1)
  move_ship(ship, move_end.x, move_end.y, move_end.angle)

  -- no player ships are in range, return false
  --log("no player ships in range")
  return false
end

function get_player_ships()
  local player_ships = {}
  for i, entity in ipairs(entities) do
    if entity.type == "ship" and entity.owner == "player" then
      add(player_ships, entity)
    end
  end
  return player_ships
end

function get_distance(ship1, ship2)
  -- get the distance between two ships
  local x1 = ship1.x
  local y1 = ship1.y
  local x2 = ship2.x
  local y2 = ship2.y
  local distance = sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
  return distance
end