Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard' => 'dashboard#index', :as => 'dashboard'
  end
  devise_for :users
  get 'index' => 'page#index', :as => 'index'
  root :to => 'page#index'
end
