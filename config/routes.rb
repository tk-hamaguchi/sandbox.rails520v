Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/my'      => 'my#top'
  put '/my'      => 'my#update'
  get '/my/edit' => 'my#edit', as: 'edit_my'
  get '/version' => 'api#version', defaults: { format: :text }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
end
