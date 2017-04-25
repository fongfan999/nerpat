Rails.application.routes.draw do
  root 'pages#show'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/facebook/callback', to: 'profiles#connect_to_facebook'
  get 'disconnect/facebook', to: 'profiles#disconnect_to_facebook'
  delete 'sessions/destroy', as: :logout

  get '/:username', to: 'profiles#show', as: :profile   
  get '/:username/edit', to: 'profiles#edit', as: :edit_profile
  patch '/:username', to: 'profiles#update', as: :update_profile

  resources :users, only: [] do
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
      resources :answers, except: [:index, :new]
    end
  end

  resources :questions, only: [], controller: :votes do
      get :upvote_question, as: :upvote_question
      get :downvote_question      
  end

  resources :answers, only: [], controller: :votes do
      get :upvote_answer
      get :downvote_answer
  end
end
