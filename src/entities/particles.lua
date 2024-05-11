function draw_particle(particle)
  pset(particle.x, particle.y, particle.color)
  particle.x += particle.sx
  particle.y += particle.sy
  particle.age -= 1

  if particle.age < 0 then
    del(particles, particle)
  end
end