require 'rubygems'
# bundleに入れたgemを全てrequire
require 'bundler'
Bundler.require
# sinatra-contribのオートリロードしてくれるやつはrequireする必要がある
require 'sinatra/reloader'
# app.rbもrequireする
require './app.rb'

run Sinatra::Application
