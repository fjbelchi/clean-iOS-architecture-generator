require 'rubygems'
require 'thor'
require 'JSON'

Dir[File.dirname(__FILE__) + '/ios_gen/**/*.rb'].each { |file| require file }
