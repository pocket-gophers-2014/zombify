class AddMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :title
      t.text :description
      t.string :audience
      t.boolean :has_been_called, :default => false
      t.belongs_to :event
    end
  end
end
