class Checkin
  POINTS_GAINED_FOR_FINDING_AN_INGREDIENT = 200
  CHECKINS_REQUIRED_TO_HARVEST = 10

  def self.log_individual_checkin(user, ingredient)
    user_gains_points(user)
    increment_ingredient_counter(ingredient)
    create_message_showing_individual_harvest(user, ingredient)
    complete_group_harvest_if_possible(ingredient)
  end

  def self.user_gains_points(user)
    user.update_attributes(points: user.points += POINTS_GAINED_FOR_FINDING_AN_INGREDIENT)
  end

  def self.increment_ingredient_counter(ingredient)
    ingredient.update_attribute(:counter, ingredient.counter += 1)
  end

  def self.create_message_showing_individual_harvest(user, ingredient)
    Post.create(body:"#{user.name} has harvested valuable #{ingredient.name}", title:"#{ingredient.name} harvested", audience:"human")
  end

  def self.complete_group_harvest_if_possible(ingredient)
    if ingredient.counter == CHECKINS_REQUIRED_TO_HARVEST
      ingredient.update_attributes(harvested: true)

      @zombie_message = Message.where(title: "#{ingredient.name} gathered", audience: "zombie")[0]
      @human_message = Message.where(title: "#{ingredient.name} gathered", audience: "human")[0]

      Post.create(body: @zombie_message.description, title: @zombie_message.title, audience: "zombie")
      Post.create(body: @human_message.description, title: @human_message.title, audience: "human")

      @zombie_message.update_attributes(has_been_called: "true")
      @human_message.update_attributes(has_been_called: "true")
      #TODO: make next announcement message dependent on this harvest
    end
  end
end
