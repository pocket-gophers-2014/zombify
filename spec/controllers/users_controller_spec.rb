require 'spec_helper'

describe UsersController do

  context "show" do
    let(:user) { FactoryGirl.create :user }
    let(:post) { FactoryGirl.create :post }
    it "finds a specific user" do
      get :show, :id => user.id
      expect(assigns(:user)).to eq(user)
    end

    it "creates an events array for humans" do
      get :show, :id => user.id
      expect(assigns(:events)).not_to be_nil
    end

    it "creates an events array for zombies" do
      get :show, :id => user.id
      expect(assigns(:events)).to eq([])
    end
  end

  context "create" do
    it "enters a valid user into the database" do
      User.destroy_all
      params = { user: { email: "awesome@gmail.com" , password: "awesome@gmail.com" } }
      get :create, params
      expect(User.all.count).to eq(1)
    end

    it "does not enter a user with invalid username into the database" do
      User.destroy_all
      params = { user: { email: '', password: "awesome" } }
      get :create, params
      expect(User.all.count).to eq(0)
    end

    it "create a zombie 25% of the time" do
    # better test wanted - perhaps with seed
      100.times{
        user = User.create(email: Faker::Internet.email, password: Faker::Number.number(6))
        num = (1..100).to_a.sample
        user.infected = true if num > 75 
        user.save
      }
      total = User.where(infected: true).count
      (20..30).to_a.should include(total)
    end

  end
end



