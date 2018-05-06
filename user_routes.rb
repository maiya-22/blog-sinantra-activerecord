require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'faker'
require 'json'

require_relative './app.rb'

# TO RUN THESE ROUTES:  
#                       START APP WITH 'ruby user_routes.rb' IN THE COMMAND-LINE:

# get ONLY the html string for the sign-up form:
get '/user/new' do
    # create an 'error_already_exists' key on the sessions object, and give it a default value:
    session[:already_exists_error] = false
    # Rendering partial directly from app, for now:
    erb "partials/forms/_sign_up_form".to_sym, :layout => false, locals: {signed_in: signed_in?, already_exists_error: session[:already_exists_error]}
end


