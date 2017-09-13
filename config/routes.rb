Rails.application.routes.draw do

  resources :listings
  root :to => 'pages#index'

  get "users/:id/mypage" => "users#show" , as: "show_users"


#amazon-ecs
  get "game/search" => "books#search" , as: "game_search"
  #root to: 'books#search'
  resources :books
#boardGame-search
  get "myboardgame/:id/search" =>"listings#search", as: "BoardGame_search"

  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks',
     registrations: 'registrations'
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
