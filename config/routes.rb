Rails.application.routes.draw do
  get 'welcome/index'

  match 'features', to: 'features#index', via: :get
  match 'browsers', to: 'browsers#index', via: :get
  match 'graphs', to: 'graphs#index', via: :get

  resources :browsers, only: [:show]

  root 'welcome#index'
end
