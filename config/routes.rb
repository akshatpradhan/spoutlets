Spoutlets::Application.routes.draw do
# root to: 'entries#index'
# To make home index spec pass:
  root to: 'home#index'
  resources :entries
  resources :users, only: [:edit, :index, :show, :update, ]
# match 'signin'  => 'sessions#new',     as: :signin
# match 'signout' => 'sessions#destroy', as: :signout
  match 'signin'                  => 'sessions#new'
  match 'signout'                 => 'sessions#destroy'
  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure'            => 'sessions#failure'
end
