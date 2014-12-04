#!/usr/bin/env ruby

require 'rubygems'
require 'thor'
require 'JSON'
Dir['./ios_gen/**/*.rb'].each { |file| require file }

# CLI for generator
class IOSgen < Thor

  desc 'spec', 'Generate files with spec file'
  method_option :destination, aliases: '-d', desc: 'destination path'
  method_option :languague, aliases: '-l', desc: 'objc or swift'
  def spec(file_path)
    puts file_path
    generator = IOSGen::Generator::BaseGenerator.new(file_spec: file_path)
    generator.generate
  end
end

IOSgen.start
