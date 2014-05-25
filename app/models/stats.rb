class Stats

	def self.total_humans
		User.where(infected: false).count
	end

	def self.total_zombies
		User.where(infected: true).count
	end

	def self.percent_zombies
		self.total_zombies.to_f / self.total_players
	end

	def self.percent_humans
		self.total_humans.to_f / self.total_players
	end

	def self.total_players 
		User.all.count
	end

end