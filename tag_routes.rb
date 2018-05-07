require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'faker'
require 'json'

Dir[settings.root + "/models/*.rb"].each {|file| require file}
require_relative './app.rb'

# TO RUN THESE ROUTES:  
#                       START APP WITH 'ruby tag_routes.rb' IN THE COMMAND-LINE:

# working:
# get all tags:
get "/tag-routes/tag" do
    Tag.all.to_json
end

# def find_by_id_or_name(model, identifier)

# end

# working:
# get a tag by name
get "/tag-routes/tag/:name" do
    Tag.where({name: params[:name]}).to_json
end

# working:
# get all of the posts with a certain tag-name
get "/tag-routes/tag/:tag_name/post" do
    @tag = Tag.where({name: params[:tag_name]})[0]
    @tag.posts.to_json
end

# working:
# get all of the blogs whose posts have a certain tag-name
get "/tag-routes/tag/:tag_name/blog" do
    @tag = Tag.where({name: params[:tag_name]})[0]
    @blogs = []
    @tag.posts.each do |post|
        @blogs.push(post.blog)
    end
    @blogs.to_json
end

# working:
# get all tags on a certain post:
get "/tag-routes/post/:post_id/tag" do    
    @post = Post.find_by_id(params[:post_id])
    @tags = @post.tags
    @tags.to_json
end

# working: 
# get all of the tags that are on a certain blog
get "/tag-routes/blog/:blog_id/tag" do
   @tags = []
   @unique_values = {}
   @posts = Blog.find_by_id(params[:blog_id]).posts
   @posts.each do |post|
        post.tags.each do |tag|
            if(!@unique_values[tag.name])
                @tags.push(tag.name)
            end
            @unique_values[tag.name] = true
        end
   end
   @tags.to_json
 end


# working:
 #  Get all the blogs that have a certain tag:
get "/tag/:tag_name/blog" do
    @tag = Tag.where(name: params[:tag_name])[0]
    @blogs = []
    @tag.posts.each do |post|
        @blogs.push(post)
    end
    @blogs.to_json
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

# NOT WORKING leaving orphans
# STOPPED working to destroy a tag and remove its associations form the "posts_tags" table
delete "/tag-routes/tag/destroy" do
    body = JSON.parse request.body.read  # body: {id: number} or {name: string}
    @tag_to_destroy = Tag.where(body)[0] 
    @tag_to_destroy.destroy
    # p "TAG TEST NAME:"
    # p @tag_test.name
    # @tag_test.destroy
    redirect "/tag"
end


# do do:
# add a tag to a post:
# remove a tag from a post:


# IN PROGRESS:
# REMOVE ALL THE TAGS FROM A POST:
# destroy a post and is comments and those comment's tags, and 
delete "/test/post/:post_id/tag/destroy" do
    @post = Post.find_by_id(params[:post_id])
    
end
