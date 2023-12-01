function enemy_move(ship)
  if t() % 2 == 0 then
    local potential_targets = search_player_ship(ship)
    enemy_move_execute(ship, potential_targets)
  end
end

function enemy_shoot(ship)
  if t() % 2 == 0 then
    local potential_targets = search_player_ship(ship)
    enemy_shoot_execute(ship, potential_targets)
  end
end

function enemy_shoot_execute(ship, ships_to_shoot)
  if #ships_to_shoot > 0 then
    -- pick a random solution
    local solution = rnd(ships_to_shoot)
    shoot_ship(ship, solution)
  else
    -- pass the turn
    ship.has_shot = true
  end
end

function enemy_move_execute(ship, solutions)
  if #solutions > 0 then
    -- pick a random solution
    local solution = rnd(solutions)

    -- move the ship
    local move_end = calc_move_end_position(ship, solution.move_type, solution.speed, solution.direction)
    move_ship(ship, move_end.x, move_end.y, move_end.angle)
  else
    -- move closer to the closest player ship
    local player_ships = get_player_ships()
    local closest_ship = nil
    local closest_distance = 9999
    for i, player_ship in ipairs(player_ships) do
      local distance = get_ships_distance(ship, player_ship)
      if distance < closest_distance then
        closest_ship = player_ship
        closest_distance = distance
      end
    end

    local move_types = { "turn", "bank" }
    local direction = "right"
    if closest_ship.x < ship.x then
      direction = "left"
    end

    local speed = 1
    if closest_ship.y < ship.y then
      speed = flr(rnd(ship.max_speed)) + 1
    end

    -- pick a random move type
    local move_type = rnd(move_types)

    -- move the ship
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
      if battle_phase == "movement" then
        -- theres three types of moves a ship can do:
        -- straight, turn and bank
        -- each move can have a different speed, based on the ship's max speed
        -- turn and bank can rotate the ship +- 90º or 45º, respectively
        -- for each move combination, check if the player ship would be in range
        -- if it is, add it to the potential solutions
        -- if not, continue to the next move combination

        -- todo: si ningún movimiento es una solución este turno,
        -- ejecutar el movimiento que más nos acerque a cualquier nave del jugador

        local move_types = { "straight", "turn", "bank" }
        local directions = { "right", "left" }

        for move_type in all(move_types) do
          if move_type == "straight" then
            calc_enemy_move_solutions(ship, player_ship, solutions, move_type)
          else
            for direction in all(directions) do
              calc_enemy_move_solutions(ship, player_ship, solutions, move_type, direction)
            end
          end
        end
      elseif battle_phase == "shoot" then
        -- check if the player ship is in range
        local x1, y1, x2, y2 = calc_range_vertices(ship.x, ship.y, ship.max_range, ship.angle)
        if is_enemy_in_range(player_ship.x, player_ship.y, ship.x, ship.y, x1, y1, x2, y2) then
          add(solutions, player_ship)
        end
      end
    end

    return solutions
  end
end

function calc_enemy_move_solutions(ship, player_ship, solutions, move_type, direction)
  for i = 1, ship.max_speed do
    local move_end = calc_move_end_position(ship, move_type, i, direction)
    local distance = get_ships_distance(move_end, player_ship)
    if distance <= ship.max_range * 8 then
      local x1, y1, x2, y2 = calc_range_vertices(move_end.x, move_end.y, ship.max_range, move_end.angle)
      if is_enemy_in_range(player_ship.x, player_ship.y, move_end.x, move_end.y, x1, y1, x2, y2) then
        add(solutions, { move_type = move_type, speed = i, direction = direction })
      end
    end
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