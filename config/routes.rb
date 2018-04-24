Rails.application.routes.draw do
  get 'welcome/index'

  match 'features', to: 'features#index', via: :get
  match 'browsers', to: 'browsers#index', via: :get

  root 'welcome#index'
end
