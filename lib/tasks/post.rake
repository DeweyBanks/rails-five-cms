require 'csv'
namespace :post do
  desc "Publish all post"
  task publish_posts: :environment do
    posts = Post.where.not(:status => "published")
    posts.each do |post|
      post.status = "published"
      post.published_at = Time.zone.now
      post.save
    end
  end

  desc "Update Post Categories"
  task update_categories: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'post_update.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      if row["new_category"].nil?
      else
        post = Post.find_by(title: row["title"])
        category = Category.find_by(name: row["new_category"].split(",").first)
        if post.present? && category.present?
          post.category = category
          post.save
        else
          puts "ERROR :::::::::::::::::::::::::::::::::: #{row["id"]}"
        end
      end
    end
  end

  desc "Update Post Status"
  task update_status: :environment do
    posts = Post.live_posts
    posts.update_all(status: "published")
    puts "updated post status"
  end

  desc "Update Post Status"
  task :pull_missing => :environment do |name|
   category = Category.find_by(name: "Uncategorized")

   base_posts = File.read(Rails.root.join('lib', 'seeds', 'ehe-wp-3-22.csv'))
   bp = CSV.parse(base_posts, :headers => true)

   csv_text = File.read(Rails.root.join('lib', 'seeds', 'missing-posts.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      post = Post.find_or_create_by(slug: row["slug"])
      post.slug = row["slug"].downcase
      post.title = row["title"]
      post.body = row["body"]
      post.category = category
      post.status = "preview"
      if row["title"] == "Maintaining Health While Healthy Part 1: Getting There"
        post.slug = "Maintaining-Health-While-Healthy-Part-1"
      end
      if row["title"] == "Maintaining Health While Healthy Part 2: Food"
        post.slug = "Maintaining-Health-While-Healthy-Part-2"
      end
      if row["title"] == "Maintaining Health While Healthy Part 3: Organic Foods"
        post.slug = "Maintaining-Health-While-Healthy-Part-3"
      end
      if row["title"] == "Maintaining Health While Healthy Part 4: Nutrition Facts Label and Ingredients List"
        post.slug = "Maintaining-Health-While-Healthy-Part-4"
      end
      if row["title"] == "Maintaining Health While Healthy Part 5: Food and Mood"
        post.slug = "Maintaining-Health-While-Healthy-Part-5"
      end
      if row["title"] = "What You Need to Know About Hives"
        post.slug = "what-you-need-to-know-about-hives"
      end

      original_post = bp.select { |r| r["Title"] == row["title"] }.first
      urls = original_post["Image URL"].split("|")
      post.main_image =  URI.parse(urls.first)
      post.save
      puts "saved post:: #{post.title}"
    end
  end

end
