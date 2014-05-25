require 'spec_helper'

describe Game do 
	before do 
		Game.destroy_all
		Post.destroy_all
		@game = Game.create
		@game.messages << Message.all
	end

	it "show_first_message should show 1 message for zombies" do
		@game.show_first_message
		expect(Post.where(audience: "zombie").count).to eq(1)
	end

	it "show_first_message should show the correct message for zombies" do
		@game.show_first_message
		expect(Post.find_by_audience("zombie").body).to eq("I am the hive-mind. You and all of my zombie children are an extension of my own self - my eyes and ears, my hands and feet. I will speak to you from time to time to tell you of events that affect the zombie horde.Your primary goal is to grow the zombie horde by consuming humans. Each human you convert increases the strength of the horde.")
	end
end