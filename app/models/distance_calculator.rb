class DistanceCalculator
  def initialize(firstPair, secondPair)
    @firstPair  = firstPair
    @secondPair = secondPair
  end

  def distance
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlon_rad = (@secondPair[1]-@firstPair[1]) * rad_per_deg  # Delta, converted to rad
    dlat_rad = (@secondPair[0]-@firstPair[0]) * rad_per_deg

    lat1_rad, lon1_rad = @firstPair.map! {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = @secondPair.map! {|i| i * rad_per_deg }

    @firstPair = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math.asin(Math.sqrt(@firstPair))

    rm * c # Delta in meters
  end
end
