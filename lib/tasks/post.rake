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

end
