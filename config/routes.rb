Rails.application.routes.draw do
  root to: 'home#index'

  resources :configs

  namespace :hooks do
    post :github, to: 'github#create'
    post :aws, to: 'aws#create'
  end
end
