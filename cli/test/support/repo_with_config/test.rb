#!/usr/bin/env ruby

unless File.exist?('pass')
  puts 'YOU SHALL NOT PASS'
  exit 1
else
  puts 'Fly you fools!'
  exit 0
end
