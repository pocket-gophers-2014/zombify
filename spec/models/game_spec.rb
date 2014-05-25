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

	it "show_first_message should show 1 message for humans" do
		@game.show_first_message
		expect(Post.where(audience: "human").count).to eq(1)
	end

	it "show_first_message should show the correct message for zombies" do
		@game.show_first_message
		expect(Post.find_by_audience("zombie").body).to eq("I am the hive-mind. You and all of my zombie children are an extension of my own self - my eyes and ears, my hands and feet. I will speak to you from time to time to tell you of events that affect the zombie horde.Your primary goal is to grow the zombie horde by consuming humans. Each human you convert increases the strength of the horde.")
	end

	it "show_first_message should show the correct message for humans" do
		@game.show_first_message
		expect(Post.find_by_audience("human").body).to eq("To all who are currently tuned in to this station, we are the last surviving humans in the city. We will keep you up to date on the state of research as we know it. What is the situation now, you may ask? Our scientists tell us that a cure is in progress, but that several steps remain to complete it. We will let you know as soon as we can how you can help us to create the cure. In the meantime, please stay safe! Avoid the Zombies, for they seek to infect you.")
	end

	# it "shows correct first location message for zombies" do
	# 	@game.show_first_location_message
	# 	p Post.where(title: "First Location Announcement", audience: "zombie")
	# 	expect(Post.where(title: "First Location Announcement", audience: "zombie")[0].body).to eq("There are great pulses of life coming from Market and Fifth. Go there - feed and increase our numbers. For the good of the horde!")
	# end

end