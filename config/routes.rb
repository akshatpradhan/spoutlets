Spoutlets::Application.routes.draw do
  devise_for :therapists

  resources :therapists

  resources :entries do
    put :like, on: :member
    put :unlike, on: :member
  end

  root :to => 'home#index'
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/therapists/auth/:provider/callback', to: 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/home' => 'home#index'
end
