require 'rubygems'

require 'bundler'
Bundler.require

require 'sinatra/reloader'

require './app.rb'

run Sinatra::Application
