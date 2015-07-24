RottenMangoes::Application.routes.draw do
  
  root to: 'movies#index'
  get "/search", to: "movies#search"
  resources :admin, only: [:index,:create,:new]
  resources :movies do
    resources :reviews, only: [:new, :create, :index]
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy, :index] do 
    member do 
      post :preview_mode
    end
  end
  
  namespace :admin do 
    resources :users
  end

end

