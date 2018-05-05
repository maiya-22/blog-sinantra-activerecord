require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

# require the app and all of the models:
require_relative './app'
require_relative './repl'
Dir[settings.root + "/models/*.rb"].each {|file| require_relative file}