Rails.application.routes.draw do
  get 'welcome/index'

  match 'features', to: 'features#index', via: :get
  match 'browsers', to: 'browsers#index', via: :get
  match 'graphs', to: 'graphs#index', via: :get

  # Add browser pages with a URL that uses the browser_id,
  # e.g. `/browsers/chrome`.
  resources :browsers, param: :browser_id, only: [:show]

  root 'welcome#index'
end
