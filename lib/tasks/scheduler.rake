desc "This task is called by the Heroku scheduler add-on"
task :create_game => :environment do
  puts "Instantiating game"
  game = Game.create
  puts "New game created: #{game}"
  game.messages << Message.all
  game.set_code_and_times
end

task :start_game => :environment do
	game = Game.first
	if DateTime.current > game.start_time
		game.game_active = true
		game.save
		Game.first.show_first_message
	end
end

task :check_events => :environment do 
  puts "Checking for fate events"
  #something goes here
end