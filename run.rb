#!/usr/bin/env ruby
require_relative('amidakuji')
num_choices = ARGV[0].to_i
trees = [Amidakuji::Tree.new(num_choices)]
num_choices.times do
  trees << trees.last.next_step
end

trees.each do |tree|
  puts(tree.to_s)
  STDIN.gets
end