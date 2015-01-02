require 'simplecov'
require 'coveralls'
require 'thor'

Dir['./lib/**/*.rb'].each { |f| require f }

SimpleCov.start do
  add_filter '/spec/'
end
Coveralls.wear!
