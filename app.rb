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
# ACTIONS RELATED TO POSTS:

# WORKING: get all posts and order most recent:
get "/post" do
    Post.all.order(id: :desc).limit(20).to_json
end

# WORKING: gets posts by id or by title
get "/post/:identifier" do
    @identifier_is_integer = Integer(params[:identifier]) rescue false #returns false if not an integer
    if @identifier_is_integer
         @post = Post.find(params[:identifier])
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


# *********************************************************************************************
# ACTIONS RELATED TO TAGS:

# WORKING: retrieve all tags on a certain post:
get "/post/:post_id/tag" do    
    @post = Post.find(params[:post_id])
    @tags = @post.tags
    @tags.to_json
end

# WORKING: retrieve all tags
get "/tag" do
    Tag.all.to_json
end

# WORKING: retreive a tag by its id:
get "/tag/:tag_id" do
    @tag = Tag.find(params[:tag_id])
    @tag.to_json
 end

# WORKING: retrieve posts for a certain tag:
get "/tag/:tag_name/post" do
    # @tag = Tag.find(params[:tag_id])
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
   @blog = Blog.find(params[:blog_id])
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
# The original tag was being deleted;  but getting erros when try to
# In postman:  
# QUESTION: How to destroy a collection.  Why was looping through the collection
# and destroying each association not working?
# how to set up models to automatically destroy all dependencies
# how to se tup models to only destroy some dependencies (ie delete the PostTag, but not the posts)
# Maybe this is why some tutorials say that you should have the 'has_and_belongs_to_many' ?
# in the url: DELETE  http://localhost:4567/tag/destroy
# in the request body {"tag_name":"tagNameToDestroy"}
delete "/tag/destroy" do
    params = JSON.parse request.body.read
    @tag = Tag.where(name: params["tag_name"])[0].id
    PostTag.where(tag_id: @id).destroy_all
    @tag.destroy
    redirect "/tag"
end
