Spoutlets::Application.routes.draw do
  resources :entries


  root :to => 'entries#index'
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'

  #Adding this route although I do not believe you need it anymore, since your root seems to point
  #to entires? But this will make the home_controller_spec test pass.
  match '/home' => "home#index"
end
