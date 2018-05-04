class User < ActiveRecord::Base
    has_one :demographic, dependent: :destroy
    has_many :blogs, dependent: :destroy
    has_many :comments # maybe do not destroy the comments a user has made?
end
