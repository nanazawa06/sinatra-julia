# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './calcurate_julia'

get '/' do
  @number = Bar.new.len('abcds')
  erb :index
end
