ENV['GEM_PATH'] = '/home/USER/.gems:/usr/lib/ruby/gems/1.8'
require 'rubygems'
require 'sinatra'

require 'johnryding.rb'
run Sinatra::Application