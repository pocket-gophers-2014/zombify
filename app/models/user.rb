class User < ActiveRecord::Base
	attr_accessible :email, :phone_number, :password_digest 
	belongs_to :game

end