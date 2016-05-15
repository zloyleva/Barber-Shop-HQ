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

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hh = {:username => 'Enter your name', :phone => 'Enter your phone', :datetime => 'Enter date and time'}

	@error = hh.select{|key, _| params[key] == ''}.values.join(', ')

	if @error != ''
		
		return erb :visit
	end

	new_client = Client.new :name => "#{@username}", :phone => "#{@phone}", :datestamp => "#{@datetime}", :barber => "#{@barber}", :color => "#{@color}"
	new_client.save

	erb "Thanks #{@username}! Our meneger will call you."
end