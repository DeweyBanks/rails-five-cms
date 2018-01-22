Rails.application.routes.draw do
  root 'home#index'
  resources :foos

  get "/pages/*page" => "home#show"

end
