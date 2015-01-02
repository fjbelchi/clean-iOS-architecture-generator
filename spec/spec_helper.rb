require 'simplecov'
require 'coveralls'
require 'thor'

Dir['./lib/**/*.rb'].each { |f| require f }


SimpleCov.start
Coveralls.wear!
