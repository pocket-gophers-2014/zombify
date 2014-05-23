class User < ActiveRecord::Base
	attr_accessible :email, :phone_number, :password
	belongs_to :game
  validates :email, :presence => true
  has_secure_password

  def password
  end
end