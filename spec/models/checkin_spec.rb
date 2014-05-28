require 'spec_helper'

describe Checkin do
  before do 
    @user = User.create
    @user.points = 0
    @ingredient = Ingredient.create(title: "earth", counter: 10)
    @post_num = Post.all.count 
  end

	specify "user should gain 200 points given a successful individual harvest" do
    Checkin.user_gains_points(@user)
    expect(@user.points).to eq(200)
  end

  specify "ingredient counter should increase by one after each individual harvest" do
    Checkin.increment_ingredient_counter(@ingredient)
    expect(@ingredient.counter).to eq(11)
  end

  specify "message created after individual harvest" do
    Checkin.create_message_showing_individual_harvest(@user, @ingredient)
    expect(Post.all.count).to eq(@post_num + 1)
  end

  # specify "ingredient harvested by group after 10 harvests" do
  #   Checkin.complete_group_harvest_if_possible(@ingredient)
  #   expect(ingredient.harvested).to eq(true)
  # end
end