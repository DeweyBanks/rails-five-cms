namespace :post do
  desc "Publish all post"
  task publish_posts: :environment do
    posts = Post.where.not(:status => "published")
    posts.each do |post|
      post.status = "published"
      post.save
    end
  end

end
