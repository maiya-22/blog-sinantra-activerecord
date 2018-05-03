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



    #THESE LINES ARE WORKING, BUT IT SEEMS LIKE A HACK
    #WHAT IS THE BETTER WAY OF DOING THE QUERY? 
    # @post = Post.find(1)
    # @tags = Post_tag.where(post_id: @post.id)
    # p @tags


    "testing join table queries"
end


# retrieve all tags
get "/tags" do
    p " ***  ALL TAGS **  /n"
    p Tag.all.to_json
end

# retrieve all tags on a certain post:
get "/post/:post_id/tags" do
    # p " ***  ALL TAGS ON A CERTAIN POST **  /n"
    # @post = post.find(params[:post_id])
    # @tags = @post.tags
end