Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/my' => 'my#top'
  get '/version' => 'api#version', defaults: { format: :text }
  root to: 'home#index'
end
