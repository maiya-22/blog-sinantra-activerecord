class Tag < ActiveRecord::Base

    # has_and_belongs_to_many :posts
    # has_and_belongs_to_many :posts, :through => :posts_tags
    # has_many :posts, through: :posts_tags

    # has_many :poststags
    # has_many :posts, through: :poststags
    has_and_belongs_to_many :posts, :through => :posts_tags
    # has_many :post_tags 
    # has_many :posts, through: :post_tags, dependent: :destroy
    
end