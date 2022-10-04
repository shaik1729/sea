Rails.application.routes.draw do
  resources :magazines
  resources :articles do
    member do
      put :approve
      put :reject
    end
    collection do
      get :search
    end
  end

  resources :documents do
    member do
      put :approve
      put :reject
    end
    collection do
      get :search
    end
  end
  
  get 'home/index'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :batches
  resources :regulations
  resources :courses
  resources :departments
  resources :roles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  #put 'approve_document', to: 'documents#approve_document', as: 'approve_document'
end
