class Tag < ActiveRecord::Base
    has_many :posts_tags
    has_and_belongs_to_many :posts, :through => :posts_tags
    # has_and_belongs_to_many :posts, :through => :posts_tags
end