Spoutlets::Application.routes.draw do
  devise_for :users
  devise_for :therapists, controllers: {
    omniauth_callbacks: "therapists/omniauth_callbacks",
    invitations: "therapists/invitations"}

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new', as: :signin
    get 'signout', to:  'devise/sessions#destroy', as: :signout
  end

  resources :users
  get 'signup', to: "users#new", as: :signup

  resources :therapists

  devise_scope :therapist do
    delete 'signout', to:  'devise/sessions#destroy', as: :therapist_signout
  end

  resources :entries do
    put :like, on: :member
    put :unlike, on: :member
  end

  root to: 'home#index'
end
