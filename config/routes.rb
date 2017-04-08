Rails.application.routes.draw do
  root 'pages#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  delete 'sessions/destroy', as: :logout
end
