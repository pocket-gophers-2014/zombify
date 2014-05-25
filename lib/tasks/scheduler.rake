desc "This task is called by the Heroku scheduler add-on"
task :create_game => :environment do
  puts "Instantiating game"
  game = Game.create
  puts "New game created: #{game}"
  game.messages << Message.all
end

task :start_game => :environment do
	if Time.now > Game.first.start_time
		Game.first.game_active = true
		Game.first.show_first_messages
	end
end

task :check_events => :environment do 
  puts "Checking for fate events"
  #something goes here
end