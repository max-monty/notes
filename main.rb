#!/usr/bin/env ruby

$LOAD_PATH << "#{ENV['NOTESCRIPT']}/lib"

require 'utils'
require 'commands'
require 'stack'
require 'project'

Kernel.trap("INT") { puts "\n"; exit; } 

if __FILE__ == $0
  c = Commands.new
  s = Stack.new
  u = Utils.new
  p = Project.new

  if ARGV.length == 0 or ARGV[0] == '-h' or ARGV[0] == '--help'
    u.show_help
  elsif ARGV[0] == 'new' 
    c.new
  elsif ARGV[0] == 'remove'
    c.remove
  elsif ARGV[0] == 'search'
    c.search
  elsif ARGV[0] == 'edit'
    c.edit
  elsif ARGV[0] == 'scratch'
    c.scratch
  elsif ARGV[0] == 'journal'
    c.journal
  elsif ARGV[0] == '-l' or ARGV[0] == '--list'
    c.list
  elsif ARGV[0] == 'stack'
    if ARGV.length == 1 or ARGV[1] == '-d' or ARGV[1] == '--default'
      s.default
    elsif ARGV[1] == '-n' or ARGV[1] == '--new'
      s.new
    elsif ARGV[1] == '-l' or ARGV[1] == '--list' 
      s.list
    elsif ARGV[1] == '-a' or ARGV[1] == '--all'
      s.all
    elsif ARGV[1] == '-r' or ARGV[1] == '--remove'
      s.remove
    elsif ARGV[1] == 'nd' or ARGV[1] == '--new-day'
      s.new_day
    else
      s.show
    end
  elsif ARGV[0] == 'push'
    s.push
  elsif ARGV[0] == 'pop'
    s.pop
  elsif ARGV[0] == 'proj'
    if ARGV[1] == '-n' or ARGV[1] == '--new'
      p.new
    elsif ARGV[1] == '-l' or ARGV[1] == '--list' 
      p.list
    elsif ARGV[1] == '-a' or ARGV[1] == '--all'
      p.all
    elsif ARGV[1] == '-r' or ARGV[1] == '--remove'
      p.remove
    elsif ARGV[1] == 'push' or ARGV[1] == 'ps'
      p.push
    elsif ARGV[1] == 'pop' or ARGV[1] == 'pp'
      p.pop
    else
      p.show
    end
  else
    u.show_help
  end
end
