#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'haml'
require 'singleton'

$srcdir = File.join( File.dirname(__FILE__), 'src')
$destdir = File.join( File.dirname(__FILE__), 'dest')

class SistopWeb
  include Singleton

  Contents = {
    'index' => '',
    'descarga' => 'Descarga',
    'compra' => 'Compra',
    'material' => 'Material adicional'
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
