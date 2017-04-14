Rails.application.routes.draw do
  root 'pages#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
  get 'disconnect/facebook', to: 'profiles#disconnect_to_facebook'
  delete 'sessions/destroy', as: :logout

  get '/:username', to: 'profiles#show', as: :profile   
  get '/:username/edit', to: 'profiles#edit', as: :edit_profile
  patch '/:username', to: 'profiles#update', as: :update_profile

  resources :users, only: [] do
    member do
      post :send_add_nerge_request
      patch :accept_add_nerge_request
      delete :decline_add_nerge_request

      post :send_add_patron_request
      patch :accept_add_patron_request
      delete :decline_add_patron_request
    end

    delete :remove_nerge, on: :member
    delete :remove_patron, on: :collection
  end

  resources :groups, only: [:show, :edit, :update] do
    resources :questions, only: [:new, :create, :show, :edit, :update,:destroy]
  end
end
