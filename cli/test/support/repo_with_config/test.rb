#!/usr/bin/env ruby

if File.exist?('pass')
  puts 'Fly you fools!'
  exit 0
else
  puts 'YOU SHALL NOT PASS'
  exit 1
end
