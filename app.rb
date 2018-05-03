require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'faker'

# require all of the models:
Dir[settings.root + "/models/*.rb"].each {|file| require file}

set :database, {adapter: 'postgresql', database: 'blog'}

enable :sessions


get '/' do
    redirect '/test'
end

get '/test' do 
    @post = Post.find(1)
    @tags = @post.tags

    p "@posts:"
    p @posts
  
    @tag = Tag.find(1)
    @posts = @tag.posts

    p "@tags:"
    p @tags
   
    "testing join table queries"
end
