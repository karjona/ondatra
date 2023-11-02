function upd_logo()
  if t() >= end_time then
    start_game()
  end
end

function drw_logo()
  cls()
  cursor(1, 1)
  color(8)
  print(t())
end