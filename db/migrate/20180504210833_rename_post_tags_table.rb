class RenamePostTagsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :post_tags, :posts_tags
  end
end
