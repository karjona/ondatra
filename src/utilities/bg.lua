function starfield()
  stars = {}
  for i = 1, 100 do
    local colors = { 1, 2, 5, 6, 7 }

    local x = rnd(128)
    local y = rnd(128)
    local c = colors[flr(rnd(#colors)) + 1]
    add(stars, { x, y, c })
  end
end

function draw_bg(level)
  -- set a background color depending on the level
  if level == 1 then
    bgcol = 0
  end

  cls(bgcol)

  -- draw a starfield
  if level == 1 then
    if not stars then
      starfield()
    else
      for star in all(stars) do
        -- 1 in 10 change of choosing this star to move
        if rnd(100) < 1 then
          -- 50% change of star moving 1px left, right up or down
          if rnd(2) > 1 then
            star[1] += rnd(2) - 1
          else
            star[2] += rnd(2) - 1
          end
        end
        pset(star[1], star[2], star[3])
      end
    end
  end
end