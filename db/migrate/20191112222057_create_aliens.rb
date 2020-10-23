class CreateAliens < ActiveRecord::Migration[5.2]
  def change
    create_table :aliens do |t|
      t.string :address
      t.float :lat
      t.float :log
      t.string :name

      t.timestamps
    end
  end
end
