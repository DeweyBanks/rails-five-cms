# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CommanderType.destroy_all
CommanderType.create([{ name: 'Physician'}, { name: 'Coach'}])
Category.destroy_all
Category.create([{name: 'News'}, {name: 'Blog'}, {name: 'PR'}, {name: 'Recipes'}])

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'ehe_ehe_posts.csv'))
# csv = CSV.read(csv_text, :headers => true, :quote_char => "^")

csv = CSV.parse(csv_text, :headers => true)


csv.each do |row|
  row = row.to_h
binding.pry

  # if TimeZone.exists?(row['id'])
  # else
  #   t = TimeZone.new
  #   t.id = row['id']
  #   t.offset = row['offset']
  #   t.name = row['name']
  #   t.abbr = row['abbr']
  #   t.save!
  #   puts "#{t.id}, #{t.offset}, #{t.name} saved"
  # end
end

