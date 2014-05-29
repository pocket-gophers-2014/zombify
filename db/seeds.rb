#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 	3rd ingredient, put proper message in


locations_lats_long = [[ 37.784173, -122.408087],[40.723255, -73.986153],[37.784816, -122.397387],[40.761835, -73.977303],[37.776645, -122.394187]]

cure_ingredients = ["Emergen-C", "cyrillian daffodils", "whiteboard markers", "jalapenos", "glycerine"]
locations = ["Market and Fifth", "Yerba Buena, behind the waterfall", "633 Folsom", "MoMa", "Fourth and King"]

locations.each_with_index do |location, index|
	Ingredient.create(name: cure_ingredients[index],  code: rand(1000000), latitude: locations_lats_long[index][0], longitude: locations_lats_long[index][1], discovered: false, harvested: false, title: location, counter: 0, city: 'San Francisco', state: 'California', zip: 94122 )
end

zombie_messages = [
	["Incoming Communication","I am the Hive Queen. You and all of my children are an extension of my self - my eyes and ears, my hands and feet. Your primary goal is to grow the zombie horde by consuming and converting humans."],
	["You Must Go...","There are great pulses of life coming from an area the humans call #{locations[0]}. Go there - feed and increase our numbers. For the good of the horde!"],
	["Another Ingredient!","I feel the warmth of life from the direction of #{locations[1]}. They seek to destroy us with the weapon they are building. We must stop them and increase our numbers. For the good of the horde!"],
	["It Is Time!","The livestock are gathering at a place they call #{locations[2]}. We must stop them once and for all before they complete their vile brew! For the good of the horde!"],
	["Humans Detected!","My children, I sense a gathering of humans at #{locations[3]}. Travel there and consume them! For the good of the horde!"],
	["Humans Detected!","There is a final gathering of humans at #{locations[4]}. Feed! Increase our numbers! For the good of the horde!"],
	["Half humans converted","Excellent, my children. Half of the humans have been turned. The hive queen is pleased."],
	["90% humans converted","Yesssss….most of the humans have been converted. Hunt down the stragglers - each and every one of them."],
	["#{cure_ingredients[0]} gathered","Augghh! The humans have been harvesting materials for a poisonous brew. You must stop them before they complete it and attack us."],
	["#{cure_ingredients[1]} gathered","Graaaugh! My children, how can you disappoint me so? The humans have collected another ingredient. Soon their weapon will be complete. We must not allow that to come to pass."],
	["#{cure_ingredients[2]} gathered","Yarghh! The filthy humans have collected all of the ingredients they need. We can still destroy them before they destroy us. Kill them all quickly! For the good of the horde!"],
	["#{cure_ingredients[3]} gathered","Rauugh! The humans only lack one ingredient to complete their weapon. I order you to destroy them immediately!"],
	["#{cure_ingredients[4]} gathered","Noooo! The filthy humans have collected all of the ingredients they need. We can still destroy them before they destroy us. Kill them all quickly! For the good of the horde!"],
	["Cure created","Nooooooooooooo! The humans have completed their vile brew. Avoid them if at all possible!"],
	["All Humans converted","Rejoice my children! There are no humans remaining. Game Over."]
]

human_messages = [
	["Incoming Communication","To any who can hear this transmission, we are the last surviving humans in the city. We have an update on the state of the ongoing research into this troubling infection. Our scientists tell us that a cure is in progress, but that several steps remain to complete it. We will let you know as soon as we can how you can help."],
	["You Must Go...","We need at least 10 humans to travel to #{locations[0]}, to harvest a cure ingredient, #{cure_ingredients[0]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run. Zombies tend to gather where cure ingredients can be found."],
	["Another Ingredient!","We need at least 10 humans to travel to #{locations[1]}, to harvest a cure ingredient, #{cure_ingredients[1]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run!"],
	["It Is Time!","We need at least 10 humans to travel to #{locations[2]}, to harvest a cure ingredient, #{cure_ingredients[2]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run. The Zombie threat is always present."],
	["Attention Survivors!","We need at least 10 humans to travel to #{locations[3]}, to harvest a cure ingredient, #{cure_ingredients[3]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run. As you know, Zombies tend to gather where cure ingredients can be found."],
	["Attention Survivors!","We need at least 10 humans to travel to #{locations[4]}, to harvest a cure ingredient, #{cure_ingredients[4]}. When you arrive, please look for a code and check in to let us know that you gathered it, then run!"],
	["Half humans converted","Despair! Half of the remaining humans have been infected by the Zombie disease."],
	["90% humans converted","Alas, Babylon...Most of the humans have fallen to the Zombie infection."],
	["#{cure_ingredients[0]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[0]}. We are now one step closer to cure completion. Please listen in for any cure updates."],
	["#{cure_ingredients[1]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[1]}. Our scientists confirm that they are narrowing down the next location, which we hope to announce soon."],
	["#{cure_ingredients[2]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[2]}. We are now very close to cure completion. We will contact you as soon our scientists have the cure available."],
	["#{cure_ingredients[3]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[3]}. We are very close to cure completion. There is only one remaining cure location. We will contact you with its address as soon as we can."],
	["#{cure_ingredients[4]} gathered","Attention...We have successfully gathered a cure ingredient, #{cure_ingredients[4]}. We have now gathered all cure ingredients. Please listen in for an announcement regarding the cure. Our scientists tell us that it won't be long now!"],
	["Cure created","Rejoice humans! We have created a cure for this Zombie Plague. You may now cure Zombies through confrontations, but beware -- Zombies can still overpower humans from time to time."],
	["All Zombies cured","The Zombie threat has been vanquished! All Zombies have been cured. Game Over."]
]

zombie_messages.each do |title,description|
	Message.create(title:title, description:description, audience:"zombie")
end

human_messages.each do |title,description|
	Message.create(title:title, description:description, audience:"human")
end