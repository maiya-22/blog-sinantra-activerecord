The name of the database is "blog"

To seed, run "rake db:seed" in the command-line
Then comment-out the seed file, so that it does not create duplicate entries later.

![alt text](https://github.com/maiya-22/blog-sinatra-active-record/master/path/to/img.png)

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
