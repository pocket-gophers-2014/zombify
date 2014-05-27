class Ingredient < ActiveRecord::Base
  attr_accessible :discovered, :harvested, :counter, :name, :code, :latitude, :longitude, :title, :city, :state, :zip

  def latlong
    [latitude.to_f, longitude.to_f]
  end
end

