class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.string :pic
      t.string :bio
      t.date :birthday
    end
  end
end
