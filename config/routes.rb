Rails.application.routes.draw do
  devise_for :admins
  devise_for :regulars
  resources :asks
  resources :bids
  root to: 'home#index'
  get 'stocks/search'
  post 'stocks/search' => 'stocks#create', as: 'stocks_create'
  get 'stocks/show/:id' => 'stocks#show', as: 'stocks_show'
  get 'asks/show/:id' => 'asks#show', as: 'asks_show'
  get 'asks' => 'asks#create', as: 'asks_create'

end
