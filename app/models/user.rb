class User < ActiveRecord::Base
	attr_accessible :email, :phone_number, :password, :password_digest 
	has_secure_password
	belongs_to :game

	validates :email, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

	validates :email, uniqueness: true

	validates :password_digest, length: { in: 6..20 }

  def password
  end

  def should_be_infected
    num = (1..100).to_a.sample
    num > 75 
  end

end