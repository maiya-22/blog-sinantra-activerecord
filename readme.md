The name of the database is "blog"

To seed, run "rake db:seed" in the command-line
Then comment-out the seed file, so that it does not create duplicate entries later.

To start the server:
to see the views, start the app with 'ruby app.rb'
to test the tag-json routes, start the app with 'ruby tag_routes.rb'

# Use Postman to make requests. Put the body of the request (form fields) in the "Body" tab of postman:

https://www.getpostman.com/apps
![alt text](https://raw.githubusercontent.com/maiya-22/blog-sinatra-active-record/master/images_for_readme/put_request_postman.png)

The relationships are:

One to One:

* User has one Demographic

One to Many:

* User has many Blogs

One to Many

* Blogs have many Posts

One to Many

* Posts have many Comments

Many to Many

* Comments have many Tags and Tags Have many Comments

Goal:
To understand how to set up and query these relationships.

###############
