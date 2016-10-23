Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  mount ActionCable.server => '/cable'

  resources :projects
  resources :machines
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  get '/profile' => 'users#show', as: :profile
  root 'home#index'
end
