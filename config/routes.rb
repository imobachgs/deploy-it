Rails.application.routes.draw do
  resources :projects
  resources :machines
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  get '/profile' => 'users#show', as: :profile
  root 'home#index'
end
