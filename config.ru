if File.directory?("/home/johnryding/johnryding.com") then
  # Production
  ENV['GEM_PATH'] = '/home/johnryding/.gems:/usr/lib/ruby/gems/1.8'
end
 
require 'rubygems'
require 'sinatra'

require 'johnryding.rb'
run Sinatra::Application