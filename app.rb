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

# test to make sure works:
def record_exists?(model, key_value_hash)
    model.where(key_value_hash)[0] != nil ? true : false
end

# *********************************************************************************************


get '/' do
    redirect '/test'
end

get '/test' do 
    # @tag = Tag.find(1)
    # @posts = @tag.posts
    # @posts.to_json
    "testing"
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
    @post = Post..find_by_id_by_id(params[:post_id])
    @tags = @post.tags
    @tags.to_json
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

# NOT WORKING 
# The original tag was being deleted;  but getting erros when try to delete dependencies
# QUESTION: How to destroy a collection.  Why was looping through the collection
# and destroying each association not working?
# how to set up models to automatically destroy all dependencies
# how to se tup models to only destroy some dependencies (ie delete the PostTag, but not the posts)
# Maybe this is why some tutorials say that you should have the 'has_and_belongs_to_many' ?
# In postman:  
# in the url: DELETE  http://localhost:4567/tag/destroy
# in the request body {"tag_name":"tagNameToDestroy"}
delete "/tag/destroy" do
    params = JSON.parse request.body.read
    @tag = Tag.where(name: params["tag_name"])[0].id
    PostTag.where(tag_id: @id).destroy_all
    @tag.destroy
    redirect "/tag"
end
