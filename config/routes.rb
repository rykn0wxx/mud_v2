Rails.application.routes.draw do

  namespace :admin do
    get 'dashboard' => 'dashboard#index', :as => 'dashboard'
    resources :dim_contacts do
      collection do
        post :do_import
        get :import
      end
    end
    # get 'contacts' => 'dim_contacts#index', :as => 'contacts'
  end

  devise_for :users
  get 'index' => 'page#index', :as => 'index'
  root :to => 'page#index'
end
