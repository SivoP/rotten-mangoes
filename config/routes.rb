RottenMangoes::Application.routes.draw do
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
  root to: 'movies#index'

  namespace :admin do 
    resources :users
  end

end

