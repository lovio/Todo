require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require 'json'
require 'sequel'
require 'logger'

configure do 
  enable :cross_origin
  set :allow_headers,["Content-Type"]
	set :allow_origin, :any
	set :allow_methods, [:get, :post, :delete, :put]
end
Dir[File.dirname(__FILE__)+'/lib/*.rb'].each {|file| require file}
