class Game < ActiveRecord::Base
	has_many :users
	has_many :events

	after_initialize :set_code_and_times

	def set_code
		game_code = self.game_code = SecureRandom.hex(3)
		while Game.find_by_game_code(game_code) != nil
			game_code = self.game_code = SecureRandom.hex(3)
		end
		game_code
	end

	def set_code_and_times
		self.game_code ||= set_code
		self.start_time ||= Time.now
		self.end_time ||= Time.now + 86400
	end
end