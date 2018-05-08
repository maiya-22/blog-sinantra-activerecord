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

@user = User.find_by_id(1)
result = @user || "user not found"

get '/' do 
    # capture possible errors from the session object:
    already_existing_user_name_error = session[:already_existing_user_name_error] || false
    does_not_exist_error = session[:does_not_exist_error]  || false
    # clear the errorors for later page refreshes
    session[:already_existing_user_name_error] = false
    session[:does_not_exist_error] = false 
    @blogs = params[:id] != nil ? Blog.where({user_id: session[:id]}).order(created_at: :desc) : Blog.all.shuffle
    # what if it is just a single blog?
    erb :index, :layout => true, :locals => {:signed_in => signed_in?,:user_name => session[:user_name] || nil, :blogs => @blogs, :does_not_exist_error => does_not_exist_error, :already_existing_user_name_error => already_existing_user_name_error}
end

# in progress:
get "/blog/:blog_id/view" do
    @blog = Blog.find_by_id(params[:blog_id])
    erb :display_blog, :layout => true,  :locals => {:signed_in => signed_in?, :user_name => session[:user_name] || nil, :blog => @blog, :does_not_exist_error => false}
end

# change to a post route:
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
    @new_user_name = params[:user_name]
    @already_existing_user_name = User.where(user_name: @new_user_name)[0]
    if(@already_existing_user_name != nil)
        session[:already_existing_user_name_error] = true
        redirect "/"
    end
     
end


# <form id="signUp" action="/sign-up" method="post">
# <h1>Sign Up</h1>
#     <label for="user_name">User Name</label>
#     <input id="newUserName" type="text" name="user_name">
#     <label for="password">password</label>
#     <input type="text" name="password">
#     <input type="submit" value="Submit">
# </form>



# send all miscelaneous routes to the root route
# get "/*" do
#     redirect "/"
# end


