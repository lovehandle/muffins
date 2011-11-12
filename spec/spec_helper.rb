require 'rubygems'
require 'bundler/setup'
require 'rspec'

def fixture_file(filename)
  File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
end

require File.expand_path('../../lib/muffins', __FILE__)