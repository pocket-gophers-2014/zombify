class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :email
  		t.string :phone_number
  		t.string :password_digest
  		t.string :handle
  		t.string :infected
  		t.integer :points
  		t.integer :cures
  		t.integer :infections
  		t.integer :mod
  		t.belongs_to :game
  	end
  end

end
