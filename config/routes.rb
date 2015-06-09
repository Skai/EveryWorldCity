Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'index#index'
  get 'get_photos' => 'index#get_photos'
  get 'get_cities/:country' => 'index#get_cities'
  post 'tweet_now' => 'admin/dashboard#tweet_now'
  resources :cities, :path => '/', :controller => :index, :only => [:show]
  resources :contacts, :only => [:new, :create]
end
