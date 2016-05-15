#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, {presence: true}
	validates :phone, {presence: true}
	validates :datestamp, {presence: true}
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
	if new_client.save
			erb "Thanks! Our meneger will call you."
	else
		@error = 'Check input data'
		erb :visit
	end
	
end