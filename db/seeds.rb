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

csv_text = File.read(Rails.root.join('lib', 'seeds', 'wp-post.csv'))
# csv = CSV.read(csv_text, :headers => true, :quote_char => "^")

csv = CSV.parse(csv_text, :headers => true)

pr_id = Category.find_by(name: 'PR').id
blog_id = Category.find_by(name: 'Blog').id



csv.each do |row|
  row = row.to_h
  p = Post.new
  p.id = row["id"]
  p.title = row["Title"]
  p.body = row["Content"]
  if row["Date"].length == 8
    p.created_at = Time.zone.parse(row["Date"]).utc
  end
  category = row["Categories"]
  if category == "Press Release"
    p.category_id = pr_id
  else
    p.category_id = blog_id
  end
  if row["Tags"].present?
    p.all_tags = row["Tags"].gsub("|", ",")
  end

  if row["Excerpt"].present?
    p.meta_description = row["Excerpt"]
  else
    p.meta_description = row["Title"]
  end
  if row["Image URL"].present?
    begin p.main_image =  URI.parse(row["Image URL"])
    rescue
      next
    ensure
      puts "moving on"
    end
  end
  p.valid?

  p.save
  puts "Saved #{p.id}: #{p.title}"
end

