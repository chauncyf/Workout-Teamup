Rails.application.routes.draw do
  root 'index#home' # can be called as root_path

  get 'map/show', as: :map_path

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :photos
  resources :user_locations
  resources :gyms
  resources :activity_tags
  resources :tags
  resources :comments
  resources :ratings
  resources :activity_participants
  resources :activities
  resources :follows
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
