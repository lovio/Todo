require 'sinatra'
require 'sinatra/json'
require 'json'
require 'sequel'
require 'logger'
Dir[File.dirname(__FILE__)+'/lib/*.rb'].each {|file| require file}
