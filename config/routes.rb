Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :batches
  resources :regulations
  resources :courses
  resources :departments
  resources :roles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
