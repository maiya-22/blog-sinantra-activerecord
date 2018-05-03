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



# Actions related to tags:

# WORKING: retrieve all tags on a certain post:
get "/post/:post_id/tags" do    
    @post = Post.find(params[:post_id])
    @tags = @post.tags
    @tags.to_json
end

# WORKING: retrieve all tags
get "/tag/all" do
    Tag.all.to_json
  end

# WORKING: retrieve posts for a certain tag:
get "/tag/:tag_name/posts" do
    # @tag = Tag.find(params[:tag_id])
    @tag = Tag.where(name: params[:tag_name])[0]
    @posts = @tag.posts
    @posts.to_json
end

# WORKING: Blogs have comments that have tags.  Get all the blogs that have a certain tag:
get "/tag/:tag_name/blogs" do
    @tag = Tag.where(name: params[:tag_name])[0]
    @blogs = []
    @tag.posts.each do |post|
        @blogs.push(post)
    end
    @blogs.to_json
end



# delete a tag and remove all of it's references from the join table:
delete "/tag/:tag_id/" do
    # delete the tag
    # delete it off of the join table, but do not delete associated posts
    
end
