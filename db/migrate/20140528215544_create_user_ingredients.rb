class CreateUserIngredients < ActiveRecord::Migration
  def change
    create_table :user_ingredients do |t|
      t.belongs_to :user
      t.belongs_to :ingredient
      t.timestamps
    end
  end
end
