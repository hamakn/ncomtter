Ncomtter::Application.routes.draw do
  resources :users unless Rails.env.production?

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/:provider/failure" => "sessions#failure"
  delete "/logout" => "sessions#destroy", :as => :logout

  get "/following" => "following#index"
  get "/icons" => "icons#index"

  root :to => 'index#index'
end
