# -*- coding: utf-8 -*-
require 'gruff'

# Distribución de estado por respuesta
g = Gruff::StackedBar.new
g.replace_colors ['#00cc00', '#cccc00', '#cc0000', '#770000']

g.data('Correcta',     [ 3, 11,  1, 12,  7,  3,  3, 10])
g.data('Parcial',      [11,  3,  3,  4,  6,  8,  6,  9])
g.data('Incorrecta',   [ 6,  6,  0,  4,  7,  4,  8,  0])
g.data('No respondió', [ 0,  0, 16,  0,  0,  5,  3,  1])

g.labels = {0 => '1.1', 1 => '1.2', 2 => '1.extra', 3 => '2.1',
            4 => '2.2', 5 => '3.1', 6 => '3.2', 7 => '3.3'}

g.write('01_por_respuesta.png')

# Distribución de calificaciones
g = Gruff::Bar.new
g.data('Calificaciones obtenidas',
       [4.0, 1.0, 4.2, 5.7, 4.0, 3.5, 6.0, 7.8, 6.7, 7.1,
        6.4, 7.5, 8.5, 8.5, 3.5, 8.4, 2.8, 6.4, 5.7, 5.0].sort.reverse)
g.minimum_value=0
g.maximum_value=10
g.write('01_por_calif.png')
