class Message < ActiveRecord::Base
	attr_accessible :title, :description, :audience, :has_been_called

	belongs_to :game

  def self.zombie_messages
    Message.where(audience: "zombie")
  end

  def self.human_messages
    Message.where(audience: "human")
  end

end