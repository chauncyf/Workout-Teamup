Rails.application.routes.draw do
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

  root "index#home"
end
