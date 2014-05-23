require 'spec_helper'

describe User do
	before do @user = User.create(email: "user@example.com", password_digest: "poopin")
	end
	subject { @user }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
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
			@user_2 = User.new(email: "user@example.com")
			@user_2.should_not be_valid
		end

		it "is unique" do
			@user_2 = User.new(email: "something@example.com", password_digest: "something")
			@user_2.should be_valid
		end
	end

	describe "password" do

		it "is not present" do 
			@user.password_digest = " "
			@user.should_not be_valid
		end

		it "is not long enough" do
			@user.password_digest = 'ab'
			@user.should_not be_valid 
		end

		it "is too long" do
			@user.password_digest = "ljshdflshflshflsdhflshflskhflsfdhsldfhlskfsf"
			@user.should_not be_valid
		end
	end
	
end