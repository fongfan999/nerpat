Rails.application.routes.draw do
  get 'profiles/show'

  root 'pages#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  delete 'sessions/destroy', as: :logout

  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
  resources :profiles, only: [:show] do
    collection do
      get 'edit'
      patch 'update'
    end
  end
end
