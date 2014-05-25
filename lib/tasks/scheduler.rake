desc "This task is called by the Heroku scheduler add-on"
task :create_game => :environment do
  puts "Instantiating game"
  game = Game.create
  puts "New game created: #{game}"
  game.messages << Message.all
  game.set_code_and_times
end

task :start_game => :environment do
	p DateTime.current
	p Game.first.start_time
	p "********************"
	if DateTime.current > Game.first.start_time
		Game.first.game_active = true
		Game.first.save
		Game.first.show_first_message
	end
end

task :check_events => :environment do 
  puts "Checking for fate events"
  #something goes here
end