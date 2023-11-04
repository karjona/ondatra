function upd_battle()
  if #radio > 0 then
    if btnp(❎) then
      sfx(0)
      deli(radio, 1)
    end
  end
end

function drw_battle()
  cls(1)
  print_radio()
end