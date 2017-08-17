l = ['A', 'B', 'C', 'D', 'E']; # Todos los procesos del sistema
s = []; # Secuencia segura

reclamado = {'A' => 4, 'B' => 2, 'C' => 2, 'D' => 1, 'E' => 5}
asignado = {'A' => 1, 'B' => 1, 'C' => 2, 'D' => 0, 'E' => 3}
libres = 2

while ! l.empty? do
  p = l.find {|id| reclamado[id] - asignado[id] <= libres}
  raise Exception, 'Estado inseguro' if p.nil?
  libres += asignado[p]
  l.delete(p)
  s.push(p)
end
puts "La secuencia segura encontrada es: " + s.to_s
