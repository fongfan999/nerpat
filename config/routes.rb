Rails.application.routes.draw do

  root 'pages#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/auth/facebook/callback', to: 'profiles#connect_to_facebook'
  delete 'sessions/destroy', as: :logout

  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
  get 'disconnect/facebook', to: 'profiles#disconnect_to_facebook'

  resources :users, only: [] do
    post 'add_nerge', on: :member
  end

  get '/:username', to: 'profiles#show', as: :profile   
  get '/:username/edit', to: 'profiles#edit', as: :edit_profile
  patch '/:username', to: 'profiles#update', as: :update_profile
end
