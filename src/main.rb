#!/usr/bin/env ruby

require 'fileutils'
require 'open3'
require 'json'

Kernel.trap( "INT" ) do 
  puts "\n"
  exit 
end