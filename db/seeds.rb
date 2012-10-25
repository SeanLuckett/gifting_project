# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# PERSONAS -- these are 
Persona.find_or_create_by_title(
  title: "Athlete",
  description: "Loves to play, watch, and sideline-referee sporting matches."
  )

Persona.find_or_create_by_title(
  title: "Nerd",
  description: "Loves the newest tech gadget and often refers to themselves as 'geeky.'"
)

Persona.find_or_create_by_title(
  title: "Music Lover",
  description: "Loves listening to, playing, or finding great music."
)

Persona.find_or_create_by_title(
  title: "Artist",
  description: "Loves being creative and prefers to express themselves artistically."
)

Persona.find_or_create_by_title(
  title: "Skater/Extreme Sports",
  description: "Loves the counterculture and other 'high octane' activities."
)

Persona.find_or_create_by_title(
  title: "Outdoorsy/Adventurer",
  description: "Loves being outdoors, trying new things, and communing with nature (Ingrid wants this changed)."
)

Persona.find_or_create_by_title(
  title: "Foodie",
  description: "Loves tasting, trying, and making new foods...the more gourmet, the better.."
)

Persona.find_or_create_by_title(
  title: "Party Animal",
  description: "Loves having a good time and never misses a party."
)

Persona.find_or_create_by_title(
  title: "Couch Potato",
  description: "Loves watching TV, playing video games, and staying put."
)

Persona.find_or_create_by_title(
  title: "Afashionado",
  description: "Loves shopping, staying stylish, and looking good."
)

Persona.find_or_create_by_title(
  title: "Nature Lover/Environmentalist",
  description: "Loves the environment and is a fan of eco-friendly products."
)

# EVENTS -- these are 
Event.find_or_create_by_title(
  title: "Christmas",
  date: Date.new(2012, 12, 25),
  repeats: true
)

Event.find_or_create_by_title(
  title: "Valentine's Day",
  date: Date.new(2012, 2, 14),
  repeats: true
)
