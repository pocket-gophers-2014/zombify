class AddMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :description
      t.string :audience
      t.belongs_to :event
    end
  end
end
