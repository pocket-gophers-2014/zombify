desc "This task is called by the Heroku scheduler add-on"
task :create_game => :environment do

	Message.all.each do |message|
		message.has_been_called = false
		message.save
	end

	Ingredient.all.each do |ingredient|
		ingredient.counter = 0
		ingredient.discovered = false
		ingredient.harvested = false
		ingredient.save
	end

	Game.destroy_all
	Post.destroy_all
	User.destroy_all
  puts "Instantiating game"
  game = Game.create
  puts "New game created: #{game}"
  game.messages << Message.all
  game.set_code_and_times

  #reset users as well
  #users reset human/zombiepp
end

# this whole task ought to be refactored.  Message.has_been_called
task :start_game => :environment do
	game = Game.first
	game.game_active = true
	game.save

	# FLAW HERE - possible	3rd announcement came before 2nd, wtf?  I don't think so - error in how I implemented in rails c, check tomorrow anyway.

	if game.ready_for_3rd_announcement?
		game.show_third_location_message
		ingredient = Ingredient.find(3)
		ingredient.discovered = true
		ingredient.save
	elsif game.ready_for_2nd_announcement?
		game.show_second_location_message
		ingredient = Ingredient.find(2)
		ingredient.discovered = true
		ingredient.save
	elsif game.ready_for_1st_announcement?
		game.show_first_message
		game.show_first_location_message
		ingredient = Ingredient.find(1)
		ingredient.discovered = true
		ingredient.save
	end

	if Ingredient.where(harvested: true).count == 3
		User.all.each do |user|
			user.can_cure = true
			user.save
			game.cure_found = true
			game.save
		end
		cure_zombie = Message.where(title: "Cure created", audience: "zombie")[0]
		cure_human = Message.where(title: "Cure created", audience: "human")[0]
		Post.create(title: cure_zombie.title, body: cure_zombie.description, audience: "zombie")
		Post.create(title: cure_human.title, body: cure_human.description, audience: "human")
	end

	# once Time.current > game.end_time
	# game inactive for 2 hrs, then create_new_game
end

#Adding to DateTime.current 1 results in adding one day.  When adding to a DateTime in the database, adding 1 adds 1 second.  Weird.

task :check_events => :environment do 
  puts "Checking for fate events"
  #something goes here
end