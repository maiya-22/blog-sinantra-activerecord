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

    # WHY DON'T THE FOLLOWING LINES WORK?
    # WHAT DO I NEED TO FIX?
    # @post = Post.find(1)
    # @tags = @post.tags

    # p "@posts:"
    # p @posts
  
    # @tag = Tag.find(1)
    # @posts = @tag.posts

    # p "@tags:"
    # p @tags



    #THESE LINES ARE WORKING, BUT IT SEEMS LIKE A HACK
    #WHAT IS THE BETTER WAY OF DOING THE QUERY? 
    @post = Post.find(1)
    @tags = Post_tag.where(post_id: @post.id)
    p @tags


    "testing join table queries"
end
