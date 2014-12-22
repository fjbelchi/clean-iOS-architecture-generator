require 'rubygems'
require 'thor'
require 'json'

Dir[File.dirname(__FILE__) + '/ios_gen/**/*.rb'].each { |file| require file }
