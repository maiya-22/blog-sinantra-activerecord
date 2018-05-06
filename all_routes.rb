require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'faker'
require 'json'

require_relative './post_routes.rb'
require_relative './tag_routes.rb'
require_relative './user_routes.rb'


# to run all routes, including the test routes, type 'ruby all_routes.rb' in command-line