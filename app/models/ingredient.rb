class Ingredient < ActiveRecord::Base
  attr_accessible :discovered, :harvested, :counter, :name, :code, :latitude, :longitude, :title, :city, :state, :zip


end