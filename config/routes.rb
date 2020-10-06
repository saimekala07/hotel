Rails.application.routes.draw do
  resources :rooms
  resources :reservations
  devise_for :users

  root :to => 'reservations#home'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :reservations, only: [:index ] do
        collection do
          get :availabile_rooms
        end
      end
    end
  end
end
