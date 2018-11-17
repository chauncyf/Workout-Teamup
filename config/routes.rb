Rails.application.routes.draw do
  root 'index#home' # can be called as root_path

  get '/not_found', to: 'index#not_found'

  get 'map/show', as: :map_path

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/users/:id/edit_password', to: 'users#edit_password', as: :edit_password
  get '/users/:id/edit_avatar', to:'users#edit_avatar',as: :edit_avatar
  post '/upload_avatar/:id', to:'users#upload_avatar',as: :upload_avatar
  get '/users/:id/user_avatar_url', to:'users#user_avatar_url', as: :user_avatar_url

  post '/join_activity/:activity_id', to: 'users#join_activity'
  get '/joined_activities', to: 'users#joined_activities'
  get '/show_starter_posters/:id', to: 'activities#show_starter_posters', as: :show_starter_posters

  resources :photos
  resources :user_locations
  get '/working_user_location', to: 'user_locations#working', as: :user_location_working
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
