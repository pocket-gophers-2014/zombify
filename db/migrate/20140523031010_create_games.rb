class CreateGames < ActiveRecord::Migration
  def change
  	create_table :games do |t|
  		t.string :city
  		t.string :state
  		t.string :title
  		t.datetime :start_time
  		t.datetime :end_time
  		t.timestamps
  	end
  end

end
