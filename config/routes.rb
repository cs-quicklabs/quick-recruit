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
  resources :campaigns
  resources :user

  resources :candidates do
    collection do
      get "recent"
      get "hot"
      get "pipeline"
      get "champions"
      get "joinings"
      get "icebox"
      get "archive"
      get "incomplete"
    end
    scope module: "candidate" do
      resources :interviews
      resources :checklists
      resources :notes
      resources :emails
      resources :reviews
      resources :campaigns
      get "timeline", to: "timeline#index"
      get "resume", to: "resume#index"
      patch "/update", to: "candidate#update_bucket", as: "update_bucket"
    end
  end

  resources :members do
    scope module: "member" do
      resources :interviews
      resources :reviews
      resources :feedbacks
      get "timeline", to: "timeline#index"
    end
  end

  namespace :account do
    resources :roles, except: [:new, :show]
    resources :sources, except: [:new, :show]
  end

  scope "/settings" do
    get "/profile", to: "user#profile", as: "profile"
    get "/password", to: "user#password", as: "setting_password"
    patch "/password", to: "user#update_password", as: "edit_password"
    get "/preferences", to: "user#preferences", as: "user_preferences"
    patch "/avatar", to: "user#update_avatar", as: "avatar"
    delete "/avatar", to: "user#destroy_avatar", as: "destroy_avatar"
  end

  resources :interviews
  resources :reports
  resources :openings
  resources :buckets
  resources :pipeline
  resources :checklists
end
