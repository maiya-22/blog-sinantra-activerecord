class Blog < ActiveRecord::Base
    belongs_to :user, { :optional => false } 
    has_many :posts, dependent: :destroy
end