Spoutlets::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  resources :entries


  root :to => 'entries#index'
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/home' => 'home#index'
end
