class Post < ActiveRecord::Base
    belongs_to :blog
    has_many :posts_tags, dependent: :destroy
    has_many :tags, :through => :posts_tags
    has_many :comments, dependent: :destroy  
end