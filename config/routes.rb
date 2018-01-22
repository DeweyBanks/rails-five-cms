Rails.application.routes.draw do
  root 'home#index'
  resources :foos

  get "/pages/*page" => "home#show"
  get "/admin", to: "admin/dashboard#index", module: "admin",  as: "admin"

  namespace :admin do
    resources :posts
    resources :commanders
    resources :users
    resources :campaigns
    resources :messages, only: [:index, :show]
  end

  resources :posts, only: [:index, :show] do
    resources :comments
  end
  get "/posts/tags/:tag" => "posts#by_tag", as: "by_tag"

  Post.where.not("slug", nil).all.each do |post|
    get "/#{post.slug}", controller: "posts", action: "show", id: post.id
  end

  resources :comments do
    resources :comments
  end

  resources :tags, only: [:index, :show]

  resources :commanders, only: [:index, :show]
  resources :messages, only: [:create, :new]

  post "/email_list" => "home#email_list"

  get "*path", to: redirect('/')

end
