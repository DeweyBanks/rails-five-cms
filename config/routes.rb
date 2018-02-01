Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'

  get "/pages/*page" => "home#show", as: "pages"

  get "/admin", to: "admin/dashboard#index", module: "admin",  as: "admin"

  namespace :admin do
    resources :posts
    resources :commanders
    resources :users
    resources :campaigns
    resources :messages, only: [:index, :show, :destroy]
  end

  resources :posts, param: :slug, :path => "blog", only: [:index, :show] do
    resources :comments
  end

  get 'tags/:tag', to: 'posts#index', as: "tag"

  resources :comments do
    resources :comments
  end

  resources :commanders, only: [:index, :show]
  resources :messages, only: [:create, :new]

  post "/email_list" => "home#email_list"

  get "*path", to: redirect('/')

end
