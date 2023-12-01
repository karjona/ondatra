function upd_gameover()
  if btnp(❎) then
    start_game()
  end
end

function drw_gameover()
  cls()
  print("game over", 1, 1, 8)
end