require 'spec_helper'

describe Stats do
	before do 
		User.destroy_all 

		2.times do 
			User.create(email: Faker::Internet.email, 
				password: Faker::Number.number(6),
				infected: true)
		end

		3.times do
			User.create(email: Faker::Internet.email,
				password: Faker::Number.number(6))
		end

	end

	it "returns correct number of zombies" do
		expect(Stats.total_zombies).to eq(2)
	end

	it "returns correct number of humans" do 
		expect(Stats.total_humans).to eq(3)
	end

	it "returns correct percentage of zombies" do
		expect(Stats.percent_zombies).to eq(40)
	end	

	it "returns correct percentage of humans" do
		expect(Stats.percent_humans).to eq(60)
	end

end