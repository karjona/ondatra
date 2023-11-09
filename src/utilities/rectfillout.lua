function rectfillout(x, y, w, h, c, outc)
  if not c then c = 0 end
  if not outc then outc = 7 end

  -- outline
  rect(x, y, x + w, y + h, outc)
  -- fill
  rectfill(x + 1, y + 1, x + w - 1, y + h - 1, c)
end