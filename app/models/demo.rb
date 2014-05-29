class Demo 
	def self.set_human_zombies
		zombies = User.where(infected: true)
		humans = User.where(infected: false)
		#assumes 4 users, and must be part of game after create_game, but before create_demo
		while zombies.count > 1
			zombie = zombies.first
			zombie.infected = false
			zombie.save
		end

		if humans.count > 3
			human = humans.first
			human.infected = true
			human.save
		end	
	end


end