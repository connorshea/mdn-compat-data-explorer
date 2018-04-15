Rails.application.routes.draw do
  get 'welcome/index'
  get 'browsers/index'

  root 'welcome#index'
end
