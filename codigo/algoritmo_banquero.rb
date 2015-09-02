l = ['A', 'B', 'C', 'D', 'E']; # Todos los procesos del sistema
s = []; # Secuencia segura
while ! l.empty? do
  p = l.select {|id| reclamado[id] - asignado[id] > libres}.first
  raise Exception, 'Estado inseguro' if p.nil?
  libres += asignado[p]
  l.delete(p)
  s.push(p)
end
puts "La secuencia segura encontrada es: %s" % s
