require 'csv'
CommanderType.destroy_all
CommanderType.create([{ name: 'Physician'}, { name: 'Coach'}])
Category.destroy_all
Category.create([{name: 'News'}, {name: 'Uncategorized'}, {name: 'Blog'}, {name: 'PR'}, {name: 'Recipes'}])
User.create({email: 'admin@ehe.com', password: 'Test1234', password_confirmation: 'Test1234', super_admin: true})

csv_text = File.read(Rails.root.join('lib', 'seeds', 'ehe-wp-3-22.csv'))
# csv = CSV.read(csv_text, :headers => true, :quote_char => "^")

csv = CSV.parse(csv_text, :headers => true)

pr_id = Category.find_by(name: 'PR').id
blog_id = Category.find_by(name: 'Blog').id
uncat_id = Category.find_by(name: 'Uncategorized').id


csv.each do |row|
  row = row.to_h
  if row["Status"] == "draft"
    puts "************** Draft not saved *****************"
  else
    p = Post.new
    p.title = row["Title"]
    p.body = row["Content"]
    if row["Date"].length == 8
      p.created_at = Time.zone.parse(row["Date"]).utc
    end
    category = row["Categories"]
    if category == "Press Release"
      p.category_id = pr_id
    elsif category == "Blog"
      p.category_id = blog_id
    else
      p.category_id = uncat_id
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
        puts "added main_image..."
      end
    end
    p.valid?
    p.save
    puts "Saved #{p.id}: #{p.title}"
  end
end





