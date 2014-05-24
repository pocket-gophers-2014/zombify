require 'spec_helper'

describe User do
	before do @user = User.create(email: "user@example.com", password: "poopin")
	end
	subject { @user }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
	it { should be_valid }

	describe "user email" do

		it "is not present" do
			@user.email = " "
			should_not be_valid
		end

		it "is not valid format, no .something" do
			@user.email = "example@thing"
			should_not be_valid
		end

		it "is not valid format, no @" do
			@user.email = "example.com"
			should_not be_valid
		end

		it "is not unique" do
			@user_2 = User.new(email: "user@example.com", password: "yayayay")
			@user_2.should_not be_valid
		end

		it "is unique" do
			User.destroy_all
			@user_2 = User.new(email: "something@example.com", password: "something")
			@user_2.should be_valid
		end
	end

	# describe "password" do

	# 	it "is not present" do
	# 		@user.password = " "
	# 		@user.should_not be_valid
	# 	end

	# 	it "is not long enough" do
	# 		@user.password = 'ab'
	# 		@user.should_not be_valid
	# 	end

	# 	it "is too long" do
	# 		@user.password= "ljshdflshflshflsdhflshflskhflsfdhsldfhlskfsf"
	# 		@user.should_not be_valid
	# 	end
	# end

end