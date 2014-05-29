class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :user
      t.references :ingredient
      t.timestamps
    end
  end
end
