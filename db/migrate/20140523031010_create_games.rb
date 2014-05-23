class CreateGames < ActiveRecord::Migration
  def change
  	create_table :games do |t|
  		t.string :city, :default => 'San Francisco'
      t.string :game_code
  		t.string :state, :default => 'California'
  		t.string :title, :default => 'Zombie Apocalypse'
      t.boolean :game_active, :default => false
  		t.datetime :start_time
      t.datetime :end_time
  		t.datetime :end_time
  		t.timestamps
  	end
  end

end
