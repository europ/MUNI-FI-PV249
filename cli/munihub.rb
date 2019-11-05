#!/usr/bin/env ruby

require 'tempfile'

class Editor
  def initialize
    begin
      @editor = ENV.fetch('EDITOR')
    rescue KeyError
      raise Exception.new("Environment variable 'EDITOR' is not set!")
    end
  end

  def load(text)
    file = Tempfile.new
    begin
      write(file, text)
      retval = system("#{@editor} #{file.path}")
      if retval == true
        data = read(file)
      else
        raise Exception.new("Editor error!")
      end
    ensure
      file.close
      file.unlink
    end
  end

  def write(file, string)
    file.write(string)
    file.rewind
  end

  def read(file)
    file.rewind
    file.read
  end
end


x = Editor.new
t = x.load("hello")
puts t
