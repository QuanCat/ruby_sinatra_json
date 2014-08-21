require 'sinatra'
require 'data_mapper'
require 'date'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/messages.db")

class Message
	include DataMapper::Resource
	property :id,         Serial, key: true
	property :name,       Text, :required => true
	property :content,    Text, :required => true
	property :created_at, DateTime
	property :updated_at, DateTime

	# validates_presence_of :name
	# validates_presence_of :content
end
DataMapper.auto_migrate!