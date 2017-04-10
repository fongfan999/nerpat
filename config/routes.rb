Rails.application.routes.draw do
  root 'pages#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
  delete 'sessions/destroy', as: :logout

  get 'profile', to: 'profiles#show'
  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
  get 'disconnect/facebook', to: 'profiles#disconnect_to_facebook'

  resources :users, only: [] do
    member do
      post 'add_nerge'
      delete 'remove_nerge'
    end
  end

  get '/:username', to: 'profiles#show', as: :username 
  get '/:username/edit', to: 'profiles#edit', as: :edit_profile
  patch '/:username', to: 'profiles#update', as: :update_profile
end
