

class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
      t.string :name
  		t.string :email
  		t.string :phone_number
  		t.string :password_digest
  		t.string :handle

      # There's something in this that make me feel like something is off in
      # the design.  A User is probably like a real human being with an address
      # and credit cards.
      #
      # In the context of a Game a User becomes a Player i.e. a "role".  It
      # seems a conflation of concerns to have them on the same model.  This
      # may have issues later...TBD
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
