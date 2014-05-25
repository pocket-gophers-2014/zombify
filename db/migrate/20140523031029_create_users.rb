

class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
      t.string :name
  		t.string :email
  		t.string :phone_number
  		t.string :password_digest
  		t.string :handle
      t.boolean :can_cure, :default => false
  		t.boolean :infected, :default => false
  		t.integer :points, :default => 0
  		t.integer :cures, :default => 0
  		t.integer :infections, :default => 0
  		t.integer :mod
  		t.belongs_to :game
  	end
  end

end
