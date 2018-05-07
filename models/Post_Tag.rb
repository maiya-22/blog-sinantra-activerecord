class PostsTag < ActiveRecord::Base
	# self.table_name = "posts_tags"  #had to add this line for seed file not to give errors
	belongs_to :post
	belongs_to :tag
end