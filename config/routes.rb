Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :games
    resources :users
    resources :sessions
    resources :user_games
    resources :moves
    resources :move_twos
    mount ActionCable.server => '/cable'
  end

end
