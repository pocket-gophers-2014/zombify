class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :code
      t.float :latitude
      t.float :longitude
      t.boolean :discovered
      t.boolean :harvested
      t.string :title
      t.integer :counter
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
