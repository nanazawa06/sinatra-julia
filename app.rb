# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './ext/julia/julia'
require 'json'

get '/satori/julia' do
  erb :index
end

get '/satori/julia/api' do
  begin
    min_x = Float(params[:min_x])
    max_x = Float(params[:max_x])
    min_y = Float(params[:min_y])
    max_y = Float(params[:max_y])
  rescue ArgumentError
    halt 400, {error: 'Bad Request', message: '最大最小値には整数もしくは小数を入力してください'}.to_json
  end

  begin
    comp_str = params[:comp_const].gsub(/\s+/, '')
    unless comp_str.include?('i')
      raise(ArgumentError)
    end
    complex = Complex(comp_str)
    real_part = complex.real
    imag_part = complex.imag
  rescue  ArgumentError
    halt 400, {error: 'Bad Request', message: '複素定数を入力してください'}.to_json
  end

  julia_colors = Julia.new.calculate(min_x, max_x, min_y, max_y, real_part, imag_part)

  julia_colors.to_json
end
