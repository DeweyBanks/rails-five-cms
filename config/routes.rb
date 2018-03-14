Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'

  get "/pages/*page" => "home#show", as: "pages"

  namespace :admin do
    root to: "dashboard#index", as: "dashboard"
    resources :posts
    post "/publish_post/:id" => "posts#publish_post", as: "publish_post"
    resources :commanders
    post "/update_commanders" => "commanders#update_commanders"
    resources :users
    resources :campaigns
    resources :messages, only: [:index, :show, :destroy]
  end

  resources :posts, param: :slug, :path => "blog", only: [:index, :show] do
    resources :comments
  end

  get 'tags/:tag', to: 'posts#index', as: "tag"

  resources :commanders, only: [:index, :show]
  resources :messages, only: [:create, :new]

  post "/subscribe" => "home#subscribe"

  get "*path", to: redirect('/')

end
