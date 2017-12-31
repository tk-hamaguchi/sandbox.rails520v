Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/version' => 'api#version', defaults: { format: :text }
  root to: 'home#index'
end
