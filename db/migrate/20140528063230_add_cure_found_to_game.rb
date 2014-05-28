class AddCureFoundToGame < ActiveRecord::Migration
  def change
    add_column :games, :cure_found, :boolean, :default => false
  end
end
