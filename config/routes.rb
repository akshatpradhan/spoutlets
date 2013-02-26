Spoutlets::Application.routes.draw do
  resources :entries


  root :to => 'entries#index'
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/backstory' => 'entries#backstory', :as => :backstory
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
