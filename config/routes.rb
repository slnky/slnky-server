Rails.application.routes.draw do
  root to: 'home#index'

  scope defaults: {format: 'json'} do
    resources :configs
  end

  namespace :hooks do
    post :github, to: 'github#create'
    post :aws, to: 'aws#create'
    post :notify, to: 'notify#create'
    post :heartbeat, to: 'heartbeat#create'
  end
end
