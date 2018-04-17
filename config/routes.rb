Rails.application.routes.draw do
  get 'features/index'
  get 'welcome/index'
  get 'browsers/index'

  root 'welcome#index'
end
