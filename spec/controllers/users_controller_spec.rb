require 'spec_helper'

describe UsersController do

  context "show" do
    let(:user) { FactoryGirl.create :user }
    it "finds a specific user" do
      get :show, :id => user.id
      expect(assigns(:user)).to eq(user)
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
  end
end



