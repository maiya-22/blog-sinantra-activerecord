class Blog < ActiveRecord::Base
    belongs_to :user, { :optional => false } 
    has_many :posts
end