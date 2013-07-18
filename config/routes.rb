Spoutlets::Application.routes.draw do
  devise_for :therapists

  resources :therapists


  resources :entries do
    get :preview, on: :member # this is a custom route to render a preview of an entry created by a guest user
  end


  root :to => 'entries#index'
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/home' => 'home#index'
end
