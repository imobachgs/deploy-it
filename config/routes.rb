require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  mount ActionCable.server => '/cable'

  resources :projects do
    resources :deployments, only: [:show, :create]
  end
  resources :machines
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  get '/profile' => 'users#show', as: :profile
  root 'home#index'
end
