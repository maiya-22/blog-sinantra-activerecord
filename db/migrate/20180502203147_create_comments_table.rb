class CreateCommentsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content, default: 'content here'
      t.integer :likes, default: 0
      t.belongs_to :post, index: true
      t.belongs_to :user, index: true
    end
  end
end
