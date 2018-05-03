class Comment < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    # the user who made the comment
end