class Game < ActiveRecord::Base
	has_many :users
	has_many :messages

	attr_accessible :start_time, :game_active

	# after_initialize :set_code_and_times

	# def set_code
	# 	game_code = self.game_code = SecureRandom.hex(3)
	# 	while Game.find_by_game_code(game_code) != nil
	# 		game_code = self.game_code = SecureRandom.hex(3)
	# 	end
	# 	game_code
	# end

	def set_code_and_times
		self.start_time = DateTime.current #+ 0.0069 # slightly under 10 minutes
		self.end_time = DateTime.current + 1 # 1 day
		self.save
	end

	def show_first_message # Game.first MVP ONLY BUG BUG BUG
		messages = find_message("First Announcement")
	end

	def show_first_location_message
		find_message("First Location Announcement")
	end

	def show_second_location_message
		find_message("Second Location Announcement")
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
		messages = messages.select do |message|
			message.has_been_called == false
		end
		create_posts(messages)
	end

	def create_posts(messages)
		messages.each do |message|
			set_message_as_called(message)
			@post = Post.create(title: message[:title], body: message[:description],
				audience: message[:audience])
		end
	end

	def set_message_as_called(message)
		message.has_been_called = true
		message.save
	end

	def after_start_time
		DateTime.current > self.start_time
	end

end