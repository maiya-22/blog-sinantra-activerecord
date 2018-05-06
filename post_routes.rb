require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'faker'
require 'json'

require_relative './app.rb'

# take the 'captures' key out of the params



# to test these routes, start the app with 'ruby post_routes.rb'
# ACTIONS RELATED TO POSTS:

# WORKING: get all posts and order most recent:
get "/post" do
    Post.all.order(id: :desc).limit(20).to_json
end

# WORKING: gets posts by id or by title
get "/post/:identifier" do
    @capture_integer = filter_non_integer(params[:identifier])
    if @capture_integer
         @post = Post.find_by_id(@capture_integer)
        if @post == nil then redirect "/" else @post.to_json end
    else
        @posts = Post.where(title: params[:identifier])
        if @posts.length < 1 then redirect "/" else @posts.to_json end
    end
end

# WORKING: create a new post:
# in postman:
# in the url: POST http://localhost:4567/tag/create
# in the request body:  {"title":"I am the title","content": "I am the content"}
post '/post/create' do
    params = JSON.parse request.body.read
    @new_post = Post.create(params)
    @new_post.to_json
end

#WORKING
# postman: url: http://localhost:4567/post/202/edit
# json body: {"title":"new title", content":"some new content"} can have one or both keys
put '/post/:post_id/edit' do
  body = JSON.parse(request.body.read)
  @post = Post.find_by_id(params[:post_id]) 
  if(@post != nil)
    @post = @post.update(body)
  else
    "could not find that post"
  end
  redirect "/post/#{params[:post_id]}"    
end

# WORKING: 
# postman: url: http://localhost:4567/post/destroy
# json body: {"title":"the title", content":"the content"} can have one or both keys
# delete a post and all of its comment
delete '/post/destroy' do
    body = JSON.parse(request.body.read)
    Post.where(body)[0].destroy
    redirect "/"
end


# IN PROGRESS:
delete "/test/post/:id/destroy" do
end