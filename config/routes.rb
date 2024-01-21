Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboard#index"

  resource :registeration
  resource :session
  resource :password_reset
  resource :password

  resources :campaigns
  resources :candidates
  resources :members
  resources :interviews
  resources :reports
  resources :openings
  resources :buckets
  resources :pipeline
  resources :checklists
end
