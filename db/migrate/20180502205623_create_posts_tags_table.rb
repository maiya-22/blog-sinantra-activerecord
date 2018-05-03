class CreatePostsTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :poststags, :id => false do |t|
      # t.belongs_to :tag, index: true
      # t.belongs_to :post, index: true
      t.integer :post_id
      t.integer :tag_id
    end
  end
end

