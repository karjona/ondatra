function enemy_move(ship)
  if t() % 2 == 0 then
    local potential_targets = search_player_ship(ship)
    enemy_move_execute(ship, potential_targets)
  end
end

function enemy_shoot(ship)
  log("enemy shot!")
  ship.has_shot = true
end

function enemy_move_execute(ship, solutions)
  if #solutions > 0 then
    log("solutions found: " .. #solutions)
    -- pick a random solution
    local solution = rnd(solutions)
    if solution.move_type == "straight" then
      log("solution: " .. solution.move_type .. " " .. solution.speed)
    else
      log("solution: " .. solution.move_type .. " " .. solution.speed .. " " .. solution.direction)
    end

    -- move the ship
    local move_end = calc_move_end_position(ship, solution.move_type, solution.speed, solution.direction)
    move_ship(ship, move_end.x, move_end.y, move_end.angle)
  else
    log("no solutions found, move at random")
    -- move the ship at random
    local move_type = rnd({ "straight", "turn", "bank" })
    local speed = flr(rnd(ship.max_speed)) + 1
    local direction = rnd({ "left", "right" })
    local move_end = calc_move_end_position(ship, move_type, speed, direction)
    move_ship(ship, move_end.x, move_end.y, move_end.angle)
  end
end

function search_player_ship(ship)
  -- get all player ships
  local player_ships = get_player_ships()
  local solutions = {}

  -- for each player ship, check if it can be a possible target
  for i, player_ship in ipairs(player_ships) do
    local distance = get_ships_distance(ship, player_ship)
    local max_distance = ship.max_speed * 8 + ship.max_range * 8
    if distance <= max_distance then
      -- theres three types of moves a ship can do:
      -- straight, turn and bank
      -- each move can have a different speed, based on the ship's max speed
      -- turn and bank can rotate the ship +- 90º or 45º, respectively
      -- for each move combination, check if the player ship would be in range
      -- if it is, add it to the potential solutions
      -- if not, continue to the next move combination

      -- straight moves
      for i = 1, ship.max_speed do
        local move_end = calc_move_end_position(ship, "straight", i)
        local distance = get_ships_distance(move_end, player_ship)
        if distance <= ship.max_range * 8 then
          local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
          if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
            add(solutions, { move_type = "straight", speed = i })
          end
        end
      end

      -- right turns
      for i = 1, ship.max_speed do
        local move_end = calc_move_end_position(ship, "turn", i, "right")
        local distance = get_ships_distance(move_end, player_ship)
        if distance <= ship.max_range * 8 then
          local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
          if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
            add(solutions, { move_type = "turn", speed = i, direction = "right" })
          end
        end
      end

      -- left turns
      for i = 1, ship.max_speed do
        local move_end = calc_move_end_position(ship, "turn", i, "left")
        local distance = get_ships_distance(move_end, player_ship)
        if distance <= ship.max_range * 8 then
          local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
          if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
            add(solutions, { move_type = "turn", speed = i, direction = "left" })
          end
        end
      end

      -- right banks
      for i = 1, ship.max_speed do
        local move_end = calc_move_end_position(ship, "bank", i, "right")
        local distance = get_ships_distance(move_end, player_ship)
        if distance <= ship.max_range * 8 then
          local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
          if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
            add(solutions, { move_type = "bank", speed = i, direction = "right" })
          end
        end
      end

      -- left banks
      for i = 1, ship.max_speed do
        local move_end = calc_move_end_position(ship, "bank", i, "left")
        local distance = get_ships_distance(move_end, player_ship)
        if distance <= ship.max_range * 8 then
          local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
          if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
            add(solutions, { move_type = "bank", speed = i, direction = "left" })
          end
        end
      end
    end

    return solutions
  end
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