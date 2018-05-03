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
    @tag = Tag.find(1)
    @posts = @tag.posts
    @posts.to_json
end

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
# in the url: http://localhost:4567/tag/create
# in the request body:  {"name":"newTagName"}
post "/tag/create" do 
    params = JSON.parse(request.body.read)
    # in the body, the key is not a symbol
    Tag.create({
          name: params["name"]
          })
    redirect "/tag"
end

# delete a tag and remove all of it's references from the join table:
delete "/tag/:tag_id/" do
    # delete the tag
    # delete it off of the join table, but do not delete associated posts
    
end


