#!/usr/bin/env ruby
require 'rubygems'
require 'thor'
require './generator'

class IOSGen < Thor
  register(IOSgen::Generator, 'screen', 'screen',
  'Generate the files to create a new screen')
end

IOSGen.start
