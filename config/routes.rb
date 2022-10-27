Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root to: "home#index"

  resources :teams do
    get :update_score  
  end 
  resources :players
  resources :tournaments, except: [:edit, :update]
  resources :scores
  resources :users  
  resources :matches
end
