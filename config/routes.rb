Rails.application.routes.draw do
  resources :prefectures
  root to: 'home#top'
  get 'home/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
