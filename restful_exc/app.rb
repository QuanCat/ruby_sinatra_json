require 'sinatra'
require 'sinatra/json'
require 'data_mapper'
require 'date'
require_relative 'message'

get '/messages' do
	content_type :json
	messages = Message.all
	messages.to_json
end

get 'messages/:id' do
	content_type :json
	message = Message.get params[:id]
	message.to_json
end


post '/messages' do
	content_type :json
	message = Message.new 
	message.attributes = {
		:name => params[:name],
		:content => params[:content],
		:created_at => Time.now,
		:updated_at => Time.now
	}
	if message.save
		status 201
	else 
		status 500
		json message.errors.full_messages
	end
end

put '/messages/:id' do
	content_type :json
	message = Message.get params[:id]
	if message.update params[:message]
		status 200
		json "Message was updated"
	else
		status 500
		json message.errors.full_messages
	end
end

delete '/messages/:id' do
	content_type :json
	message = Message.get params[:id]
	if message.destroy
		status 200
		json "Message was removed!"
	else
		status 500
		json message.errors.full_messages
	end
end

