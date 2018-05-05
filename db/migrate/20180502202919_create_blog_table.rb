class CreateBlogTable < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :summary
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
