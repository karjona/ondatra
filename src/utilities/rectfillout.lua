function rectfillout(x, y, w, h, c, outc)
  -- outline
  rect(x, y, x + w, y + h, outc)
  -- fill
  rectfill(x + 1, y + 1, x + w - 1, y + h - 1, c)
end