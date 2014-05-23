class Message < ActiveRecord::Base
	belongs_to :event
	attr_accessible :title, :description, :audience
end