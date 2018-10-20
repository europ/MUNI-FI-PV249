#!/usr/bin/env ruby

operation, file_name = ARGV

content = File.read(file_name)
new_content = case operation
              when 'sign'
                "#{content.chomp}\n-- edited with fake_editor.rb\n"
              when 'leave'
                content
              when 'empty'
                ''
              else
                STDERR.puts("Unknown operation #{operation}")
                exit 1
              end

File.write(file_name, new_content)
