#!/usr/bin/env ruby

file_name = ARGV.first

content = File.read(file_name)
new_content = if content =~ /make empty/
                ''
              else
                "#{content}\n#{edited}"
              end

File.write(file_name, new_content)

