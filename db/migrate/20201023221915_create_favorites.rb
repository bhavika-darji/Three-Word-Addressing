class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
    end
  end
end
