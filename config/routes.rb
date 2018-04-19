Rails.application.routes.draw do
  get 'welcome/index'

  match 'features', to: 'features#index', via: :get
  match 'browsers', to: 'browsers#index', via: :get

  get '/features/api', to: 'features#api'
  get '/features/css', to: 'features#css'
  get '/features/html', to: 'features#html'
  get '/features/http', to: 'features#http'
  get '/features/javascript', to: 'features#javascript'
  get '/features/mathml', to: 'features#mathml'
  get '/features/svg', to: 'features#svg'
  get '/features/webdriver', to: 'features#webdriver'
  get '/features/webextensions', to: 'features#webextensions'

  root 'welcome#index'
end
