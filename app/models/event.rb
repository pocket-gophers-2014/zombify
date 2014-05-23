class Event < ActiveRecord::Base
	belongs_to :game
	has_many :messages
end