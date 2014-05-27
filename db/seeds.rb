#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This is really an example of where a YML file can save a ton of readability.
# You could create a yaml file which abstracts out the textual component of
# this came from the data needed to make it possible


# See, here if this were YAML you could have a human-readable comment to help
# me understand what was where.  "EarthElementLocation" etc.
locations_lats_long = [[ 37.784173, -122.408087],[37.776645, -122.394187],[40.761835, -73.977303],[40.723255, -73.986153],[37.784816, -122.397387]]

cure_ingredients = ["fire", "earth", "wind", "water", "heart"]
locations = ["Market and Fifth", "633 Folsom", "MoMa", "Yerba Buena, behind the waterfall", "Fourth and King"]

locations.each_with_index do |location, index|
	Ingredient.create(name: cure_ingredients[index],  code: rand(1000000), latitude: locations_lats_long[index][0], longitude: locations_lats_long[index][1], discovered: false, harvested: false, title: location, counter: 0, city: 'San Francisco', state: 'California', zip: 94122 )
end

# Oh man, please put this in YAML

zombie_messages = [
	["First Announcement","I am the hive-mind. You and all of my zombie children are an extension of my own self - my eyes and ears, my hands and feet. I will speak to you from time to time to tell you of events that affect the zombie horde.Your primary goal is to grow the zombie horde by consuming humans. Each human you convert increases the strength of the horde."],
	["First Location Announcement","There are great pulses of life coming from #{locations[0]}. Go there - feed and increase our numbers. For the good of the horde!"],
	["Second Location Announcement","I feel the warmth of life from the direction of #{locations[1]}. Feed! Increase our numbers! For the good of the horde!"],
	["Third Location Announcement","The filthy humans are gathering at #{locations[2]} and seek to destroy us with the weapon they are building. We must stop them and increase our numbers. For the good of the horde!"],
	["Fourth Location Announcement","My children, I sense a gathering of humans at #{locations[3]}. Travel there and consume them! For the good of the horde!"],
	["Fifth Location Announcement","There is a final gathering of humans at #{locations[4]}. We must stop them once and for all before they complete their vile brew! For the good of the horde!"],
	["Half humans converted","Excellent, my children. Half of the humans have been turned. The hive mind is pleased."],
	["90% humans converted","Yesssss….most of the humans have been converted. Hunt down the stragglers - each and every one of them."],
	["#{cure_ingredients[0]} gathered","Augghh! The filthy humans have collected the first ingredient for their poisonous brew. You must stop them before they complete it and attack us."],
	["#{cure_ingredients[1]} gathered","Gragh! The humans have made progress in their quest to poison us by collecting an ingredient for their poisonous brew. Stop them! For the good of the horde!"],
	["#{cure_ingredients[2]} gathered","Yarghh! My children, how can you disappoint me so? The humans have collected another ingredient. Soon their weapon will be complete. We must not allow that to come to pass."],
	["#{cure_ingredients[3]} gathered","Rauugh! The humans only lack one ingredient to complete their weapon. I order you to destroy them immediately!"],
	["#{cure_ingredients[4]} gathered","Noooo! The humans have collected all of the ingredients they need. We can still destroy them before they destroy us. Kill them all quickly! For the good of the horde!"],
	["Cure created","Nooooooooooooo! The humans have completed their vile brew. Kill them all before they can destroy us!"],
	["All Humans converted","Rejoice my children! There are no humans remaining. Game Over."]
]

human_messages = [
	["First Announcement","To all who are currently tuned in to this station, we are the last surviving humans in the city. We will keep you up to date on the state of research as we know it. What is the situation now, you may ask? Our scientists tell us that a cure is in progress, but that several steps remain to complete it. We will let you know as soon as we can how you can help us to create the cure. In the meantime, please stay safe! Avoid the Zombies, for they seek to infect you."],
	["First Location Announcement","Attention Survivors! We need at least 10 humans to travel to the next location at #{locations[0]}, to gather the next cure ingredient, #{cure_ingredients[0]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run. Zombies tend to gather where cure ingredients can be found."],
	["Second Location Announcement","Attention Survivors! We need at least 10 humans to travel to the next location at #{locations[1]}, to gather the next cure ingredient, #{cure_ingredients[1]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run!"],
	["Third Location Announcement","Attention Survivors! We need at least 10 humans to travel to the next location at #{locations[2]}, to gather the next cure ingredient, #{cure_ingredients[2]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run. The Zombie threat is always present."],
	["Fourth Location Announcement","Attention Survivors! We need at least 10 humans to travel to the next location at #{locations[3]}, to gather the next cure ingredient, #{cure_ingredients[3]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run. As you know, Zombies tend to gather where cure ingredients can be found."],
	["Fifth Location Announcement","Attention Survivors! We need at least 10 humans to travel to the next location at #{locations[4]}, to gather the last cure ingredient, #{cure_ingredients[4]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run!"],
	["Half humans converted","Despair! Half of the humans have been infected by the Zombie disease."],
	["90% humans converted","Alas, Babylon...Most of the humans have fallen to the Zombie infection."],
	["#{cure_ingredients[0]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[0]}. We are now one step closer to cure completion. Please listen in for the next cure location, which we hope to announce soon."],
	["#{cure_ingredients[1]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[1]}. Our scientists confirm that they are narrowing down the next location, which we hope to announce soon."],
	["#{cure_ingredients[2]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[2]}. We are more than half way to cure completion. We will contact you with the next location as soon as we can."],
	["#{cure_ingredients[3]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[3]}. We are very close to cure completion. There is only one remaining cure location. We will contact you with its address as soon as we can."],
	["#{cure_ingredients[4]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[4]}. We have now gathered all cure ingredients. Please listen in for an announcement regarding the cure. Our scientists tell us that it won't be long now!"],
	["Cure created","Rejoice humans! We have created a cure for the so-called Zombie Plague. You may now cure Zombies through confrontations, but beware for Zombies can still overpower humans from time to time."],
	["All Zombies cured","The Zombie threat has been vanquished! All Zombies have starved or been cured. Game Over."]
]

zombie_messages.each do |title,description|
	Message.create(title:title, description:description, audience:"zombie")
end

human_messages.each do |title,description|
	Message.create(title:title, description:description, audience:"human")
end
