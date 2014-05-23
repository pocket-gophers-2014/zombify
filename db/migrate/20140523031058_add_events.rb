class AddEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :status
      t.datetime :start_time
      t.datetime :end_time
      t.string :location_description
      t.string :location_name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :audience
      t.belongs_to :game
    end
  end
end
