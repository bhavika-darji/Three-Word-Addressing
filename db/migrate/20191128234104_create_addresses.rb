class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :add
      t.string :words
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
