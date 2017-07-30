Rails.application.routes.draw do
  devise_for :users
  get 'index' => 'page#index', :as => 'index'
  root :to => 'page#index'
end
