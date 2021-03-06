#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, {presence: true}
	validates :datestamp, {presence: true}
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	@new_client = Client.new
	@list_barbers = Barber.all
	erb :visit
end

post '/visit' do
	@list_barbers = Barber.all
	@new_client = Client.new params[:client_param]
	if @new_client.save
			erb "Thanks! Our meneger will call you."
	else
		@error = @new_client.errors.full_messages.join(', ')
		erb :visit
	end
	
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end


get '/bookings' do
	@client = Client.order('created_at DESC')
	erb :bookings
end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
end