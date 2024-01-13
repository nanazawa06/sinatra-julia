# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './julia'
require 'json'

get '/' do
  erb :index
end

get '/satori/julia' do
  min_x = params[:minx].to_f
  max_x = params[:maxx].to_f
  min_y = params[:miny].to_f
  max_y = params[:maxy].to_f
  comp_str = params[:complex]
  complex = Complex(comp_str)
  real_part = complex.real
  imag_part = complex.imag

  julia_colors = Julia.new.calculate(min_x, max_x, min_y, max_y, real_part, imag_part)

  julia_colors.to_json
end
