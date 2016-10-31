Rails.application.routes.draw do
  root "links#index"

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace 'api' do
    namespace 'v1' do
      resources :links, only: [:index, :create, :update], defaults: { format: :json }
    end
  end
end
