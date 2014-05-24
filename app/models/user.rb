class User < ActiveRecord::Base
	attr_accessible :email, :phone_number, :password
  belongs_to :game

  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  validates :email, uniqueness: true

	has_secure_password

  def password
  end

  def should_be_infected
    num = (1..100).to_a.sample
    num > 75 
  end

end