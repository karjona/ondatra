function draw_particle(particle)
  circfill(particle.x, particle.y, particle.size, particle.color)
  particle.x += particle.sx
  particle.y += particle.sy
  particle.sx *= 0.85
  particle.sy *= 0.85

  local agePercent = particle.age / particle.maxage
  if agePercent <= 0.1 then
    particle.color = 10
  elseif agePercent <= 0.25 then
    particle.color = 9
  elseif agePercent <= 0.5 then
    particle.color = 8
  elseif agePercent <= 0.7 then
    particle.color = 2
  else
    particle.color = 5
  end

  particle.age += 1
  if particle.age > particle.maxage then
    particle.size -= 0.5
    if particle.size <= 0 then
      del(particles, particle)
    end
  end
end