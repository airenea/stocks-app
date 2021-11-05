Rails.application.routes.draw do
  devise_for :admins
  devise_for :regulars
  resources :asks
  resources :bids
  resources :transactions
  root to: 'home#index'
  get 'stocks/search'
  post 'stocks/search' => 'stocks#create', as: 'stocks_create'
  get 'stocks/show/:id' => 'stocks#show', as: 'stocks_show'
  get 'asks/show/:id' => 'asks#show', as: 'asks_show'
  get 'asks' => 'asks#create', as: 'asks_create'
  get 'bids/show/:id' => 'bids#show', as: 'bids_show'
  get 'bids' => 'bids#create', as: 'bids_create'
  get 'transactions/show/:id' => 'transactions#show', as: 'transactions_show'
  get 'transactions' => 'transactions#create', as: 'transactions_create'

end
