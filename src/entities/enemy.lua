function enemy_move(ship)
  if t() % 2 == 0 then
    local potential_targets = search_player_ship(ship)
    log("enemy moved")
  end
end

function enemy_shoot(ship)
  log("enemy shot!")
  ship.has_shot = true
end

function search_player_ship(ship)
  -- get all player ships
  local player_ships = get_player_ships()
  local potential_targets = {}

  -- for each player ship, check if it is in range
  for i, player_ship in ipairs(player_ships) do
    -- get distance from enemy ship to player ship
    log("player ship: " .. player_ship.x .. ", " .. player_ship.y)

    --[[
      - si esa nave del jugador está a más de el máximo movimiento + el máximo rango de
      - disparo, esa nave ya no es potencial objetivo

      - si esa nave del jugador está a +- 136º de la nave enemiga, esa nave ya no es
      - potencial objetivo

      - para todos los demás casos, calcular si alguno de los posibles movimientos que puede
      - efectuar la nave, la ponen en rango de disparo de la nave del jugador
    ]]

    local distance = get_ships_distance(ship, player_ship)
    log("distance: " .. distance)
    local max_distance = ship.max_speed * 8 + ship.max_range * 8
    if distance <= max_distance then
      -- theres three types of moves a ship can do:
      -- straight, turn and bank
      -- each move can have a different speed, based on the ship's max speed
      -- turn and bank can rotate the ship +- 90º or 45º, respectively
      -- for each move combination, check if the player ship would be in range
      -- if it is, add it to the potential targets
      -- if not, continue to the next move combination
      -- if none of the move combinations put the player ship in range, continue to the next player ship
      -- if none of the player ships are in range, return false

      -- straight moves
      for i = 1, ship.max_speed do
        local move_end = calc_move_end_position(ship, "straight", i)
        local distance = get_ships_distance(move_end, player_ship)
        if distance <= ship.max_range * 8 then
          local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
          if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
            log("[!] good solution: moving straight w/ speed " .. i .. " will work")
            add(potential_targets, player_ship)
            break
          else
            log("[x] moving straight w/ speed " .. i .. " wont work: not in correct angle")
          end
        else
          log("[x] moving straight w/ speed " .. i .. " wont work: beyond max distance")
        end
      end
    end

    --[[
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
    --]]
  end

  log("moving speed 1 straight")
  local move_end = calc_move_end_position(ship, "straight", 1)
  move_ship(ship, move_end.x, move_end.y, move_end.angle)
  log("ship moved to: " .. ship.x .. ", " .. ship.y)

  -- no player ships are in range, return false
  --log("no player ships in range")
  return potential_targets
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

function get_ships_distance(ship1, ship2)
  -- get the distance between two ships
  local x1 = ship1.x
  local y1 = ship1.y
  local x2 = ship2.x
  local y2 = ship2.y
  local distance = sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
  return distance
end