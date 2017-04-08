Rails.application.routes.draw do
  get 'profiles/show'

  root 'pages#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  delete 'sessions/destroy', as: :logout

  get 'profile', to: 'profiles#show'
  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
end
