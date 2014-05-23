class User < ActiveRecord::Base
	belongs_to :game
  has_secure_password

  def password
  end
end