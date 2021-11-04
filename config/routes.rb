Rails.application.routes.draw do
  devise_for :admins
  devise_for :regulars
  root to: 'home#index'
  get 'stocks/search'
  post 'stocks/search' => 'stocks#create', as: 'stocks_create'
  get 'stocks/show/:id' => 'stocks#show', as: 'stocks_show'
end
