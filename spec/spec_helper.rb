require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

Dir['./lib/IOSGen/Base/**/*.rb'].each { |f| require f }
