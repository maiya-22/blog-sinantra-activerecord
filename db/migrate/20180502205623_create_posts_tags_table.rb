class CreatePostsTagsTable < ActiveRecord::Migration[5.2]
  def change
    # removed this param from before 'do' :id => false
    create_table :posts_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :post, index: true
      # t.integer :post_id
      # t.integer :tag_id
    end
  end
end

