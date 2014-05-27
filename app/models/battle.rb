class Battle < ActiveRecord::Base
  has_many :users
end

# I don't see a migration for this table?  Does it need AR?
