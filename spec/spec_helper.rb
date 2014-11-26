require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

Dir['./lib/ios_gen/**/**/*.rb'].each { |f| require f }
