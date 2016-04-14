#!/usr/bin/ruby
# coding: utf-8
class Proceso
  attr_reader(:nombre, :inicio, :duracion)
  attr_accessor(:restante)
  def initialize(nombre, inicio, duracion)
    @nombre = nombre.to_s
    @inicio = inicio.to_i
    @restante = @duracion = duracion.to_i
  end

  def llegado?(tiempo)
    return (@inicio >= tiempo) ? true : false
  end

  def tick
    raise RangeError if @restante < 1
    @restante -= 1
  end

  def to_s
    '%s: %d+%d' % [@nombre, @inicio, @duracion]
  end
end

class ListaProc < Array
  def <<(item)
    item.is_a?(Proceso) or
      raise ArgumentError, 'Sólo pueden agregarse procesos'
    super
  end

  # ¿Cuándo podemos iniciar la ejecución?
  # Cuando llegue el primero de los procesos
  def inicio
    self.sort_by{|proc| proc.inicio}.first.inicio
  end

  def tiempo_total
    tot = max = 0
    self.each do |proc|
      tot += proc.duracion
      proc_max = proc.inicio + proc.duracion
      max = proc_max if proc_max > max
    end
    return (tot > max) ? tot : max
  end
end

class Planificador
  def initialize(procesos)
    procesos.is_a?(ListaProc) or
      raise ArgumentError, 'Sólo puedo trabajar con listas de procesos'
    @procesos = procesos
    @t_actual = 0
    @salida = ''
  end

  def tick
    @t_actual += 1
    sig = siguiente
    if sig.nil?
      # No ha llegado ningún proceso
      @salida << '.'
    else
      sig.tick
      @salida << sig.nombre
    end
  end

  def corre
    while @t_actual <= @procesos.tiempo_total
      tick
    end
    return @salida
  end

  def listos
    @procesos.select { |proc|
      proc.restante >= 1 and proc.inicio < @t_actual
    }
  end

  def siguiente
    raise NoMethodError, 'Todo planificador debe implementar la función «siguiente»'
  end
end

class FIFO < Planificador
  def siguiente
    return nil if listos.empty?
    listos.sort_by{|proc| proc.inicio}.first
  end
end

class SPN < Planificador
  def siguiente
    return nil if listos.empty?
    if listos.include?(@ultimo)
      return @ultimo
    end
    @ultimo = listos.sort_by{|proc| proc.restante}.first
    @ultimo
  end
end

class PSPN < Planificador
  def siguiente
    return nil if listos.empty?
    listos.sort_by{|proc| proc.restante}.first
  end
end

class RR < Planificador
  def initialize(procesos, quantum=1)
    @quantum = quantum
    @en_quantum = 0
    super(procesos)
  end

  def siguiente
    return nil if listos.empty?
    if @en_quantum < @quantum and listos.include?(@ultimo)
      @en_quantum += 1
      return @ultimo
    else
      @ultimo = listos.first
      @en_quantum = 0
      @procesos << @procesos.delete(@ultimo)
      @ultimo
    end
  end
end

if __FILE__ == $0
  r = Random.new
  p = ListaProc.new
  r.rand(1..10).times do |item|
    # Nombre del proceso: El caracter correspondiente a 65 ('A') mas
    # el número de elemento que estemos procesando
    nombre = (65 + item).chr
    # Duración: Entre 1 y 10. Llegada: Entre 0 y 20.
    p << Proceso.new(nombre, r.rand(1..10), r.rand(0..20))
  end

  # Duplicamos p para trabajar con cada algoritmo, pues será
  # modificada en el proceso
  fifo = FIFO.new(Marshal.load(Marshal.dump(p)))
  pspn = PSPN.new(Marshal.load(Marshal.dump(p)))
  spn  = SPN.new(Marshal.load(Marshal.dump(p)))
  rr   = RR.new(Marshal.load(Marshal.dump(p)), 1)
  rr4  = RR.new(Marshal.load(Marshal.dump(p)), 4)

  puts "Lista de los %d procesos a ejecutar:" % p.size
  puts p
  puts 'Inciando la ejecución en t=%d; terminamos en t=%d' % [p.inicio, p.tiempo_total]
  puts 'FIFO: %s' % fifo.corre
  puts 'PSPN: %s ' % pspn.corre
  puts 'SPN:  %s ' % spn.corre
  puts 'RR1 : %s ' % rr.corre
  puts 'RR4 : %s ' % rr4.corre
  puts '∎'
end
