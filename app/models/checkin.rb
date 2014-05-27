class Checkin
  POINTS_GAINED_FOR_FINDING_AN_INGREDIENT = 200
  CHECKINS_REQUIRED_TO_HARVEST = 10

  class << self
    def log_individual_checkin
      user_gains_points
      increment_ingredient_counter
      create_message_showing_individual_harvest
      complete_group_harvest_if_possible
    end

    def user_gains_points
      @user.update_attributes(points: @user.points += POINTS_GAINED_FOR_FINDING_AN_INGREDIENT)
    end

    def increment_ingredient_counter
      @current_ingredient.update_attribute(:counter, @current_ingredient.counter += 1)
    end

    def create_message_showing_individual_harvest
      Post.create(body:"#{@user.name} has harvested valuable #{@current_ingredient.name}", title:"#{@current_ingredient.name} harvested", audience:"human")
    end

    def complete_group_harvest_if_possible
      if @current_ingredient.counter == CHECKINS_REQUIRED_TO_HARVEST
        @current_ingredient.update_attributes(harvested: true)

        @zombie_message = Message.where(title: "#{@current_ingredient.name} gathered", audience: "zombie")[0]
        @human_message = Message.where(title: "#{@current_ingredient.name} gathered", audience: "human")[0]

        Post.create(body: @zombie_message.description, title: @zombie_message.title, audience: "zombie")
        Post.create(body: @human_message.description, title: @human_message.title, audience: "human")

        @zombie_message.update_attributes(has_been_called: "true")
        @human_message.update_attributes(has_been_called: "true")
        #TODO: make next announcement message dependent on this harvest
      end
    end
  end
end
