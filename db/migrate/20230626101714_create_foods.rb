class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement_unit
      t.decimal :price
      t.integer :quantity
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :foods, :users, column: :user_id
    add_index :foods, :user_id
  end
end
