Rails.application.routes.draw do

  resources :advertisements

  #Call the resources method and pass it a symbol that instructs Rails
  #to create post routes for creating, updating, viewing and deleting
  #instances of Post
  resources :posts

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
