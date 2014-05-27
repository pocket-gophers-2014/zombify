class Message < ActiveRecord::Base
	attr_accessible :title, :description, :audience, :has_been_called

	belongs_to :game

  # nice!  although this might be a nice class where single table inheritance
  # is called for. you have
  #
  # Message
  #
  # ZombieMessage < Message
  # HumanMessage < Message
  #
  # They all live in `messages` with a `type` column which determines which
  # class the row is cast into.
  def self.zombie_messages
    Message.where(audience: "zombie")
  end

  def self.human_messages
    Message.where(audience: "human")
  end

end
