Rails.application.routes.draw do
  devise_for :users
  resources :articles
  get 'home', to: 'articles#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'articles#home'
end
