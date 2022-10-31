Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root to: "home#index"

  resources :teams do
    get :update_score  
  end 
  resources :players
  resources :tournaments, except: [:edit, :update]
  resources :users  
  resources :matches
  resources :match_tournaments do 
    post :create_semi_finals, on: :collection
    post :create_finals, on: :collection
  end 
end
