function upd_battle()
  -- update ship and game states

  -- we set the default battle phase to shoot
  -- if there's a ship yet to move, we set it to movement later
  selected_ship = nil
  battle_phase = "shoot"

  local ship_moved = false
  local enemies_left = 0
  local player_ships_left = 0
  local bullet_count = 0
  for entity in all(entities) do
    if entity.type == "bullet" then
      bullet_count += 1

      -- animate bullet movement
      entity.x += entity.sx
      entity.y += entity.sy

      if collide(entity.x, entity.y, 8, 8, entity.tx, entity.ty, 8, 8) then
        del(entities, entity)
        entity.target.health = 0
      end
    end

    if entity.type == "ship" then
      -- destroy ship if health is 0
      if entity.health <= 0 then
        del(entities, entity)
      end

      if entity.owner == "cpu" then
        enemies_left += 1
      end

      if entity.owner == "player" then
        player_ships_left += 1
      end

      -- animate ship movement
      if animate_ship(entity) then
        ship_moved = true
      end

      -- determine if we are on the movement phase
      if entity.has_moved == false then
        battle_phase = "movement"
      end

      if battle_phase == "shoot" then
        if selecting_target and not shot_target then
          if entity.owner != "player" then
            local x1, y1, x2, y2 = calc_range_vertices(selecting_target.x, selecting_target.y, selecting_target.max_range, selecting_target.angle)
            if is_enemy_in_range(entity.x, entity.y, selecting_target.x, selecting_target.y, x1, y1, x2, y2) then
              shot_target = entity
            end
          end
        end
      end
    end
  end

  -- check if the game is over
  if bullet_count == 0 then
    if enemies_left == 0 then
      _drw = drw_won
      _upd = upd_won
    elseif player_ships_left == 0 then
      _drw = drw_gameover
      _upd = upd_gameover
    end
  end

  if ship_moved then moving_ships = true else moving_ships = false end

  -- game logic
  if not moving_ships then
    if bullet_count == 0 then
      -- select the active ship or reset the turn
      select_ship()
      if not selected_ship then
        reset_turn()
        return
      end

      -- enemy behaviour
      if selected_ship.owner != "player" then
        if battle_phase == "movement" then
          enemy_move(selected_ship)
        end

        if battle_phase == "shoot" then
          enemy_shoot(selected_ship)
        end
      end

      -- interaction
      if selected_ship.owner == "player" then
        if btnp(❎) then
          battle_button_x()
        end

        if btnp(🅾️) then
          battle_button_o()
        end

        if btnp(⬆️) then
          battle_button_up()
        end

        if btnp(⬇️) then
          battle_button_down()
        end

        if btnp(⬅️) then
          battle_button_left()
        end

        if btnp(➡️) then
          battle_button_right()
        end
      end
    end
  end
end

function drw_battle()
  draw_bg(level)

  -- draw entities
  for entity in all(entities) do
    if entity.type == "ship" then
      draw_ship(entity)
      if entity == shot_target and not moving_ships then
        draw_shottarget(entity)
      end
    end

    if entity.type == "bullet" then
      draw_bullet(entity)
    end
  end
  if selected_ship and not moving_ships then draw_selsquare(selected_ship) end

  if battle_phase == "shoot" then
    -- draw shoot menu
  end

  -- draw move menu
  if battle_phase == "movement" then
    if selecting_move then
      draw_move_menu(selecting_move)
    end

    if confirming_orientation then
      draw_move_orientation_select(selecting_move)
    end

    if confirming_move then
      draw_move_confirm()
    end
  end

  -- draw shoot phase
  if battle_phase == "shoot" then
    if selecting_target then
      draw_rangelines(selecting_target)
    end

    if shot_target then
      print("90%", shot_target.x + 6, shot_target.y - 6, 7)
    end
  end

  -- print radio messages
  print_radio()

  -- ui
  if #radio == 0 then
    if selected_ship and selected_ship.owner == "player" then
      if not moving_ships then
        if battle_phase == "movement"
            and not selecting_move then
          print("❎ move", 91, 1, 7)
        elseif battle_phase == "shoot" then
          if not shot_target and not selecting_target then
            print("❎ shoot", 91, 1, 7)
          end
        end
        if selecting_move then
          print("🅾️ cancel", 91, 1, 7)
          print("❎ ok", 91, 8, 7)
          print("⬆️⬇️ select", 83, 15, 7)
        elseif selecting_target then
          print("🅾️ cancel", 91, 1, 7)
          print("⬅️➡️ select", 83, 15, 7)
          if shot_target then
            print("❎ fire!", 91, 8, 8)
          else
            print("❎ pass", 91, 8, 7)
          end
        end
      end
    end
  end
end

function reset_turn()
  for entity in all(entities) do
    if entity.type == "ship" then
      entity.has_moved = false
      entity.has_shot = false
    end
  end
end