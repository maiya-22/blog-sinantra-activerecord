The name of the database is "blog"

To seed, run "rake db:seed" in the command-line
Then comment-out the seed file, so that it does not create duplicate entries later.

The relationships are:

One to One:
1 - User has one Demographic

One to Many:
2 - User has many Blogs

One to Many
3 - Blogs have many Posts

One to Many

4 - Posts have many Comments

Many to Many
5 - Comments have many Tags and Tags Have many Comments

Goal:
To understand how to set up and query these relationships.

###############
