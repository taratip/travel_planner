Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'itineraries#index'
  end

  root 'pages#index'

  resources :itineraries do
    resources :hotel_bookings
    resources :flight_bookings
  end
end
