class CreateTagTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, unique: true
    end
  end
end
