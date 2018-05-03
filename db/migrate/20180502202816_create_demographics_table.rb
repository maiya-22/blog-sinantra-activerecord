class CreateDemographicsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :demographics do |t|
      t.string :gender
      t.string :generation, default: 'y'
      t.string :country
      t.belongs_to :user, index: true
      # t.string :custom_foreign_key_name (look at the Demographid model)
    end
  end
end
