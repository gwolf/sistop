# coding: utf-8

require 'fusefs'
require 'yaml'

class YAMLFS < FuseFS::FuseDir
  def initialize(filename)
    @filename = filename
      @fs = File.exists?(filename) ? YAML.load(open(filename,'r').read) : {}
  end

  def save
    File.open(@filename,'w') { |f| f.puts(@fs.to_yaml) }
  end

  def contents(path)
    return @fs.keys
  end

  def file?(path)
    return @fs.has_key?(unroot(path))
  end

  def read_file(path)
    return @fs[unroot(path)]
  end

  def size(path)
    return read_file(path).size
  end

  def can_write?(path)
    return path.split(//).select{|c| c=='/'}.size == 1
  end

  def write_to(path,body)
    return nil unless can_write?(path)
    name = unroot(path)
    @fs[name] = body
    save
  end

  def can_delete?(path)
    file?(path)
  end

  def delete(path)
    @fs.delete(unroot(path))
    save
  end

  private
  def unroot(path)
    return path.gsub(/^\//, '')
  end
end

if (File.basename($0) == File.basename(__FILE__))
  if (ARGV.size < 2)
    puts "Uso: #{$0} <dir> <yaml>"
    exit
  end

  dirname, yamlfile = ARGV[0], ARGV[1]
  unless File.directory?(dirname)
    puts "Uso: #{dir} no es un directorio."
    exit
  end

  root = YAMLFS.new(yamlfile)
  FuseFS.set_root(root)
  FuseFS.mount_under(dirname)
  FuseFS.run
end
