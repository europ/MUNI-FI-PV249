#!/usr/bin/env ruby

file_name = ARGV.first

content = File.read(file_name)
new_content = if content =~ /make empty/
                ''
              else
                "#{content.chomp}\n-- edited with fake_editor.rb\n"
              end

File.write(file_name, new_content)

