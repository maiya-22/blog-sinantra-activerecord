require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'faker'
require 'json'


# require all of the models:
Dir[settings.root + "/models/*.rb"].each {|file| require file}

set :database, {adapter: 'postgresql', database: 'blog'}

enable :sessions

# USE POSTMAN TO TEST THESE ROUTES:
# https://www.getpostman.com/products
# put the form-fields as a JSON object in the 'body' panel of the postman app

# *********************************************************************************************

# HELPER FUNCTIONS

def filter_non_integer(value)
    Integer(value) rescue false #returns false if not an integer or else returns the integer
end

# test to make sure works:  see if a record exists, option to return original or not
def matching_record(model, key_value_hash, return_record=false)
    @record = model.where(key_value_hash)[0]
    @exists = @record != nil ? true : false
    if(return_record && @exists)
        return @record
    end
    @exists
end

def signed_in?
    # not sure if the session[:id] automatically exists as nil, or if we create it from scratch?
    p session.has_key?(:id)
    session[:id] != nil
end



before do
    params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
end
def clear_session_errors
    session[:does_not_exists_error] = false
end
def reset_session
    session[:id] = nil
    clear_session_errors
end

# to do: make a route that sends the error status to an ajax call
# make an ajax call that will trigger re-setting errors to none 


get '/' do 
    does_not_exist_error = session[:does_not_exist_error] #capture this error if it was set by the sign-in route
    session[:does_not_exist_error] = false # clear the error for later page refreshes
    @blogs = params[:id] != nil ? Blog.where({user_id: session[:id]}).order(created_at: :desc) : Blog.all.shuffle
    erb :index, :layout => true, :locals => {:signed_in => signed_in?,:user_name => session[:user_name] || nil, :blogs => @blogs, :does_not_exist_error => does_not_exist_error || false}
end

get '/sign-out' do
    reset_session
    redirect '/'
end

post '/sign-in' do
    # so that request can come from the form or from postman:
    body = params.key?(:body) ? params[:body] : JSON.parse(request.body.read)
    @user = User.where(body)[0]
    @users = User.all
    if(@user == nil)
        session[:does_not_exist_error] = true
        redirect "/"
    else
        session[:id] = @user.id
        session[:user_name] = @user.user_name
        session[:does_not_exists_error] = nil
        redirect "/"
    end
end

# should this route be named post "/user/create" ?
post "/sign-up" do
     
end




