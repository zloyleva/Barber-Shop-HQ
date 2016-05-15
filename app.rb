#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	#@barbers = Barber.all
	erb :index
end

get '/visit' do
		
	erb :visit
end

post '/visit' do

	new_client = Client.new params[:client_param]
	new_client.save

	erb "Thanks! Our meneger will call you."
end