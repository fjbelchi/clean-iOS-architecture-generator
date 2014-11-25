#!/usr/bin/env ruby
require 'rubygems'
require 'thor'
require './generator'

class IOSgen < Thor
  register(Generator, 'screen', 'screen',
  'Generate the files to create a new screen')
end

IOSgen.start
