require 'simplecov'
require 'coveralls'
require './lib/iosgen'

SimpleCov.start
Coveralls.wear!

Dir['./lib/ios_gen/**/**/*.rb'].each { |f| require f }
