class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, default: 'title here'
      t.string :content, default: 'content here'
      t.belongs_to :blog, index: true
      t.timestamps
    end
  end
end
