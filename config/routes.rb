Rails.application.routes.draw do
  get 'index' => 'page#index', :as => 'index'
  root :to => 'page#index'
end
