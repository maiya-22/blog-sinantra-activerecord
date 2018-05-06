This is a learning assignment.

The name of the database is "blog."

Set up:
Run these commands in the command-line
rake db:create
rake db:migrate
rake db:seed
then, comment out the seed-file

Several options for starting the server:
to see the views, start the app with 'ruby app.rb' and make requests, per usual, in the browser
(PORT 4567)

To test the json routes, run one of the files in the root directory, named: 'ruby [resource-name]\_routes.rb'
Example: type 'app tag_routes.rb' in the command-line
These test routes are set up to accept requests from Postman:
Postman download: https://www.getpostman.com/apps

# Using Postman to make requests. Put the body of the request (form fields) in the "Body" tab of postman:

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
