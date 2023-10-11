Rails.application.routes.draw do
  # root 'users#index'
  root 'static_pages#home'
  get 'static_pages/about'
  get 'static_pages/home'
  get 'static_pages/help'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
