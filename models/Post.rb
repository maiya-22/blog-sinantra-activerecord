class Post < ActiveRecord::Base
    belongs_to :blog
    # has_and_belongs_to_many :tags, :through => :posts_tags

    has_many :poststags
    has_many :tags, through: :poststags


    # has_many :tags, through: :posts_tags
    # 
    # belogs_to : 
    # has_and_belongs_to_many :tags, :through => :posts_tags
    # not clear if it is the name above, or the name below?  Getting errors.
    # has_and_belongs_to_many :tags, :through => :post_tags
    # has_and_belongs_to_many :tags
    # when do you use the 'through statement below:'?
    #has_and_belongs_to_many :tags, :through => :posts_tags  #param :join_table => :custom_name
    has_many :comments
end