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
  attr_accessor :src, :dest, :srcfile, :destfile
  def self.files
    Dir.open($progsrcdir).entries.select { |f|
      File.file?(File.join($progsrcdir, f))
    }.sort.map {|f| self.new(f)}
  end

  def initialize(src)
    @src = src
    @dest = src.gsub(/\./, '_') + '.html'
    @srcfile = File.join($progsrcdir, @src)
    @destfile = File.join($progdestdir, @dest)

    process
  end

  def title
    @src
  end

  def dest_link
    'codigo/' + @dest
  end

  def process
    Dir.exists?($progdestdir) || Dir.mkdir($progdestdir)

    File.exists?(@srcfile) or raise RuntimeError, 'Archivo inexistente: «%s»' % @srcfile
    temp = CodeRay.scan( File.open(@srcfile).read,
                         CodeRay::FileType.fetch('foobar.rb', :text, true) )

    File.open(@destfile, 'w') { |f| f.puts(temp.html(:line_numbers => :table)) }
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
