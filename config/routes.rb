Rails.application.routes.draw do
  root "pages#home"

  get "auth/google_oauth2/callback", to: "sessions#create"
  delete "sessions/destroy", as: :logout

  get "auth/facebook/callback", to: "profiles#connect_to_facebook"
  get "disconnect/facebook", to: "profiles#disconnect_to_facebook"

  resources :users, only: [:show] do
    member do
      post :nerge_request
      delete :cancel_nerge_request
      patch :accept_nerge_request
      delete :decline_nerge_request
      patch :remove_nerge

      post :patron_request
      delete :cancel_patron_request
      patch :accept_patron_request
      delete :decline_patron_request
      patch :remove_patron
    end
  end

  resources :groups, only: [:show, :edit, :update], shallow: true  do
    resources :questions, except: [:index] do
      resources :answers, except: [:index]
    end
  end

  concern :votable do |options|
    member do
      controller :votes do
        post :upvote
        post :downvote
      end
    end
  end

  resources :questions, only: [], concerns: :votable
  resources :answers, only: [], concerns: :votable

  resources :notifications, only: [:index, :destroy]
  get "nerpat_requests", to: "notifications#nerpat_requests"

  resources :skills, only: [:index, :create]

  resource :settings, only: [] do
    get :account
    patch :update_account
    get :notifications
  end

  get "/:username", to: "profiles#show", as: :profile
  get "/:username/edit", to: "profiles#edit", as: :edit_profile
  patch "/:username", to: "profiles#update", as: :update_profile
end
