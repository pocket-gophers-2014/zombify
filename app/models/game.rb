class Game < ActiveRecord::Base
	has_many :users
	has_many :messages

	attr_accessible :start_time

	after_initialize :set_code_and_times

	# def set_code
	# 	game_code = self.game_code = SecureRandom.hex(3)
	# 	while Game.find_by_game_code(game_code) != nil
	# 		game_code = self.game_code = SecureRandom.hex(3)
	# 	end
	# 	game_code
	# end

	def set_code_and_times
		self.start_time ||= Time.now + 345600000
		self.end_time ||= Time.now + 86400000
	end

	def show_first_messages # Game.first MVP ONLY BUG BUG BUG
		find_message("First Announcement")
	end

	# def show_first_location_message
	# 	p Time.now
	# 	p Game.first.start_time + 180
	# 	p Time.now >= Game.first.start_time + 180000
	# 	if Time.now >= Game.first.start_time + 180000
	# 		find_message("First Location Announcement")
	# 	end
	# end

	def find_message(title)
		messages = Game.first.messages.where(title: title)
		create_posts(messages)
	end

	def create_posts(messages)
		messages.each do |message|
			@post = Post.create(title: message[:title], body: message[:description], 
				audience: message[:audience])
		end
	end

end