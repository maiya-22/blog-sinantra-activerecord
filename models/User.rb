class User < ActiveRecord::Base
    has_one :demographic
    has_many :blogs
    has_many :comments
end
