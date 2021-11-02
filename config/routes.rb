Rails.application.routes.draw do
  devise_for :admins
  devise_for :regulars
  root to: 'home#index'
end
