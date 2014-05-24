desc "This task is called by the Heroku scheduler add-on"
task :start_game => :environment do
  puts "Instantiating game"
  game = Game.create
  puts "New game created: #{game}"
end

task :check_events => :environment do 
  puts "Checking for fate events"
  #something goes here
end