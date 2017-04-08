Rails.application.routes.draw do
  get 'profiles/show'

  root 'pages#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  delete 'sessions/destroy', as: :logout
  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'

  get '/:username', to: 'profiles#show', as: :username 
  get '/:username/edit', to: 'profiles#edit', as: :edit_profile
  patch '/:username', to: 'profiles#update', as: :update_profile
end
