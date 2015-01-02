require 'simplecov'
require 'coveralls'
require 'thor'

SimpleCov.start do
  add_filter '/spec/'
end
Coveralls.wear!

Dir['./lib/**/*.rb'].each { |f| require f }
