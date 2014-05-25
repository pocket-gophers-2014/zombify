class Message < ActiveRecord::Base
	attr_accessible :title, :description, :audience

	belongs_to :game
end