function move_enemy(ship)
  log("enemy moved")
  ship.has_moved = true
end

function shoot_enemy(ship)
  log("enemy shoot!")
  ship.has_shot = true
end