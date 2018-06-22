Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'
  
  # declare the deafult page the app loads on homepage
  root 'welcome#index'
end
