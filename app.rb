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

# *********************************************************************************************


get '/' do
    redirect '/test'
end

# *********************************************************************************************
# ACTIONS RELATED TO USERS:

# sign up:

post "/user/create" do
    @new_properties
end

# *********************************************************************************************
# ACTIONS RELATED TO POSTS:

# WORKING: get all posts and order most recent:
get "/post" do
    Post.all.order(id: :desc).limit(20).to_json
end

# WORKING: gets posts by id or by title
get "/post/:identifier" do
    @capture_integer = filter_non_integer(params[:identifier])
    if @capture_integer
         @post = Post..find_by_id_by_id(@capture_integer)
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
    # Trying to find a record that does not exist should not break the app:
  @post = Post.find_by_id_by_id(params[:post_id]) 
  if @post != nil then  @post.update(body).to_json else redirect "/"  end  
end

# IN PROGRESS
# delete a post and all of its comment
delete '/post/:identifier/destroy' do
    @capture_integer = filter_non_integer(params[:identifier])
    if(@capture_integer)
        @post_to_delete = Post.find_by_id_by_id(capture_integer)
    end
end

# *********************************************************************************************
# ACTIONS RELATED TO TAGS:

# WORKING: retrieve all tags on a certain post:
get "/post/:post_id/tag" do    
    @post = Post.find_by_id(params[:post_id])
    @tags = @post.tags
    @tags.to_json
end
# WORKING test route:
# get all of the tag names associated with a certain post manually, by looping:
get "/test/post/:post_id/tag" do
    @post = Post.find_by_id(params[:post_id])
    @tags = @post.tags
    @all_associated_tags = []
    @tags.each do |tag|
        @all_associated_tags.push(tag.name)
    end
    @all_associated_tags.to_json
end

# WORKING: retrieve all tags
get "/tag" do
    Tag.all.to_json
end

# WORKING: retreive a tag by its id:
get "/tag/:tag_id" do
    @tag = Tag..find_by_id_by_id(params[:tag_id])
    @tag.to_json
 end

# WORKING: retrieve posts for a certain tag:
get "/tag/:tag_name/post" do
    # change to find by:
    @tag = Tag.where(name: params[:tag_name])[0]
    @posts = @tag.posts
    @posts.to_json
end

# WORKING: Blogs have comments that have tags.  Get all the blogs that have a certain tag:
get "/tag/:tag_name/blog" do
    @tag = Tag.where(name: params[:tag_name])[0]
    @blogs = []
    @tag.posts.each do |post|
        @blogs.push(post)
    end
    @blogs.to_json
end

# WORKING: get all of the tags that are on a certain blog
get "/blog/:blog_id/tag" do
   @blog = Blog..find_by_id_by_id(params[:blog_id])
   @tags = []
   @unique_tags_hash = {}
   @blog.posts.each do |post|
        post.tags.each do |tag|
            unless @unique_tags_hash[tag.name.to_sym]
                @tags.push(tag)
            end
            @unique_tags_hash[tag.name.to_sym] = true
        end
   end
   @tags.to_json
end

# WORKING create a new tag
# in postman:
# in the url: POST http://localhost:4567/tag/create
# in the request body:  {"tag_name":"newTagName"}
post "/tag/create" do 
    params = JSON.parse(request.body.read)
    # in the body, the key is not a symbol
    Tag.create({
          name: params["tag_name"]
          })
    redirect "/tag"
end

# this is working to destroy a tag and remove its associations form the "posts_tags" table
delete "/tag/destroy" do
    body = JSON.parse request.body.read  
    @tag_to_destroy = Tag.where(body)[0] 
    @tag_to_destroy.destroy
    redirect "/tag"
end


# TEST ROUTES:
# *********************************************************************************************
# ACTIONS RELATED TO DELETING AND DESTROYING DEPENDENCIES, AND LOOPING OVER COLLECTIONS OF DEPENDENCIES:
# need to understand 
# 1) how to set these up in the models so that they happen automatically
# 2) how to do them manually


# REMOVE ALL THE TAGS FROM A POST:
# destroy a post and is comments and those comment's tags, and 
delete "/test/post/:post_id/tag/destroy" do
    @post = Post.find_by_id(params[:post_id])
    
end

delete "/test/post/:id/destroy" do
end

# QUESTION ABOUT DEPENDENT DESTROY:
# I am deleting tags.  When I delete a tag, I want it to delete all of the associations on the PostTag table, but I do not want it to delete all of the tags.
# if there is a join table, I wa
  # @tag = Tag.find(1)
    # @posts = @tag.posts
    # @posts.to_json
 # GET 

#  find a tag

get '/test' do 
    "testing"
end


# *********************************************************************************************
# ALL DESTROY ACTIONS:



