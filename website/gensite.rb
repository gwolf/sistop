#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'haml'
require 'singleton'
require 'coderay'


$srcdir = File.join( File.dirname(__FILE__), 'src')
$destdir = File.join( File.dirname(__FILE__), 'dest')
$progsrcdir = File.join( File.dirname(__FILE__), '../codigo')
$progdestdir = File.join( $destdir, 'codigo')

class SistopWeb
  include Singleton

  Contents = {
    'index' => '',
    'descarga' => 'Descarga',
    'compra' => 'Compra',
    'material' => 'Material adicional',
    'codigo' => 'Código fuente'
  }

  def set_to(what)
    return false unless Contents.keys.include? what
    @current = what
  end

  def full_title
    base = 'Fundamentos de sistemas operativos'
    return base if title.nil? or title.empty?
    '%s ‣ %s' % [base, title]
  end

  def title
    return nil unless @current and Contents[@current]
    Contents[@current]
  end

  def body
    Haml::Engine.new(readhaml(@current)).render
  end

  def menu
    Haml::Engine.new(readhaml('_menu')).render
  end

  private
  def readhaml(file)
    File.open(File.join($srcdir, '%s.haml' % file)).read
  end
end

class SistopWeb::Progs
  attr_accessor :src, :dest, :srcfile, :destfile, :title

  CodeRay::FileType::TypeFromExt['pl'] = :perl
  CodeRay::FileType::TypeFromExt['sh'] = :shell

  Contents = [
              { :title => 'Introducción a la concurrencia: El jardín ornamental',
                :progs => [ [ 'jardin_ornamental.c', 'Programa fallido: ¿Por qué (casi) nunca suma 20+20 = 40?' ],
                            [ 'jardin_ornamental_intento_2.c', 'Segundo intento: Suspendiendo la multitarea durante la <em>sección crítica</em>' ],
                            [ 'jardin_ornamental_intento_3.c', 'Tercer intento: Utilizar una variable a modo de <em>bandera</em>' ],
                            [ 'jardin_ornamental_intento_3b.c', 'Ilustrando el fallo del tercer intento: Nueva <em>sección crítica</em>' ],
                            [ 'jardin_ornamental_intento_4.c', 'Cuarto intento: Manejar la bandera con instrucciones <em>atómicas</em>' ],
                            [ 'jardin_ornamental_intento_4b.c', '<em>Espera activa</em> del cuarto intento' ],
                            [ 'jardin_ornamental_intento_5.c', 'Quinto intento: Utilizar turnos' ],
                            [ 'jardin_ornamental_intento_6.c', 'Sexto intento: Indicar la intención de emplear la <em>sección crítica</em>' ],
                            [ 'jardin_ornamental_solucion_peterson.c', '<em>Solución de Peterson</em> aplicada a resolver el <em>jardín ornamental</em>' ]
                          ] },
              { :title => 'Introducción a la concurrencia: Venta de pasajes',
                :progs => [ [ 'reserva_autobus.pl', 'Código muestra del empleo de <em>mutexes</em> para sincronizar el uso de <em>secciones críticas</em>' ],
                            [ 'reserva_autobus.sh', 'Código en <em>shell</em> que implementa <em>mutexes</em>' ]
                          ] },
              { :title => 'Patrones de uso de semáforos',
                :progs => [ [ 'patron_senalizar.py', 'Ejemplo del patrón <em>Señalizar</em>' ],
                            [ 'patron_barrera.py', 'Ejemplo del patrón <em>Barrera</em>' ],
                            [ 'patron_cola.py', 'Ejemplo del patrón <em>Cola</em>' ],
                            [ 'patron_mutex.py', 'Ejemplo del patrón <em>Mutex</em>' ],
                            [ 'patron_rendezvous.py', 'Ejemplo del patrón <em>Rendezvous</em>' ],
                            [ 'patron_torniquete.py', 'Ejemplo del patrón <em>Torniquete</em>' ]
                          ] },
              { :title => 'Problemas clásicos de sincronización',
                :progs => [ [ 'prod_cons_v1.py', 'Primer acercamiento al problema de <em>Productores y consumidores</em>, sin considerar sincronización '],
                            [ 'prod_cons_v2.py', 'Solución a <em>Productores y consumidores</em> empleando <em>mutex</em> y <em>señalización</em>' ],
                            [ 'prod_cons_v3.py', 'Python permite un uso más <em>idiomático</em> del mutex' ],
                            [ 'lect_escr_v1.py', 'Solución a <em>Lectores y escritores</em> (permite inanición)' ],
                            [ 'lect_escr_v2.py', 'Solución a <em>Lectores y escritores</em> (evita inanición)' ],
                            [ 'filosofos_v1.py', 'Primer acercamiento la <em>cena de los filósofos</em>, empleando semáforos: Lleva a <em>bloqueo mutuo</em>' ],
                            [ 'filosofos_v2.py', 'Modificación al primer acercamiento para la <em>cena de los filósofos</em>, que elimina el <em>bloqueo mutuo</em>' ],
                            [ 'filosofos_v2b.py', 'Otra modificación válida (tal vez menos óptima) para evitar el bloqueo mutuo en la <em>cena de los filósofos</em>' ],
                            [ 'fumadores_v1.py', 'Primer acercamiento a la resolución de los <em>fumadores compulsivos</em>, empleando semáforos' ],
                            [ 'fumadores_v2.py', 'Adición y modificación de <em>intermediarios</em> que, cumpliendo los requisitos dados, resuelve a los <em>fumadores compulsivos</em>' ],
                            [ 'filosofos_monitores.c', 'El problema de la <em>cena de los filósofos</em>, em con <em>monitores</em> (no <em>semáforos</em>)' ],
                ] },
              { :title => 'Concurrencia: Otros puntos',
                :progs => [ [ 'abuso_trywait.c', 'Ejemplo de mal uso de trywait (o del error de ser optimista)' ],
                            [ 'java_synchronized.java', 'Java ofrece un esquema sincronización simple propia de la JVM basado en <em>Mutex</em>' ]
                          ] },
              { :title => 'Bloqueos mutuos',
                :progs => [ [ 'algoritmo_banquero.rb', 'Implementación muy simple del algoritmo del banquero' ]
                          ] },
	      { :title => 'Planificación de procesos',
		:progs => [ [ 'algoritmos_planificacion.rb', 'Implementación de varios de los algoritmos de planificación abordados en el texto' ]
	      ] },
              { :title => 'Administración de memoria: Consideraciones de rendimiento',
                :progs => [ [ 'rendimiento_en_arreglo.c', 'Ejemplo de la importancia de considerar al caché al recorrer un arreglo' ]
                          ] }
             ]

  def self.files
    Dir.open($progsrcdir).entries.select { |f|
      File.file?(File.join($progsrcdir, f))
    }.sort.map {|f| self.new(f)}
  end

  def initialize(info)
    @src = info[0]
    @dest = info[0].gsub(/\./, '_') + '.html'
    @title = info[1]
    @srcfile = File.join($progsrcdir, @src)
    @destfile = File.join($progdestdir, @dest)

    process
  end

  def dest_link
    'codigo/' + @dest
  end

  def language
    CodeRay::FileType.fetch(@src, :text, true).capitalize
  end

  def process
    Dir.exists?($progdestdir) || Dir.mkdir($progdestdir)


    File.exists?(@srcfile) or raise RuntimeError, 'Archivo inexistente: «%s»' % @srcfile
    temp = CodeRay.scan( File.open(@srcfile).read,
                         CodeRay::FileType.fetch('foobar.rb', :text, true) )

    File.open(@destfile, 'w') { |f| f.puts(temp.html(:line_numbers => :table, :wrap => :page)) }
  end
end

class Hamltmpl
  def initialize(tmpl)
    tmplfile = File.join($srcdir, tmpl)
    @engine = Haml::Engine.new(File.open(tmplfile).read)
  end

  def render
    @engine.render
  end
end

haml = Hamltmpl.new('_base.haml')
SistopWeb::Contents.keys.sort.each do |file|
  puts '=== %s' %file
  SistopWeb.instance.set_to(file)
  File.open(File.join($destdir, "#{file}.html"), 'w') {|f| f.puts haml.render}
end
