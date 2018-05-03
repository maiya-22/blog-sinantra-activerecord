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

    # WHY DON'T THE FOLLOWING LINES WORK?
    # WHAT DO I NEED TO FIX?
    @post = Post.find(1)
    @tags = @post.tags

    p "@tags:"
    p @tags
  
    @tag = Tag.find(1)
    @posts = @tag.posts

    p "@posts:"
    p @posts


    "testing join table queries"
end


# retrieve all tags WORKING
get "/tags" do
    p " ***  ALL TAGS **  /n"
    p Tag.all.to_json
end

# retrieve all tags on a certain post:
get "/post/:post_id/tags" do
    p " ***  ALL TAGS ON A CERTAIN POST **  /n"
    @post = Post.find(params[:post_id])
    p "@post"
    p @post

    # NOT WORKING, BUT I THINK THEY SHOULD:
    # p "@post.tags"
    # p @post.tags


    # @tags = Post_tag.where(post_id: @post.id)
    
  
    # @tags = Post_tag.where(post_id: @post.id).tags
    # p "@tags"
    # p @tags

    @tags = Tag.where(user_id: params[:user_id])
    p "@tags: " 
    p @tags 

    "testing"
end