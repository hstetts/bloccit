Rails.application.routes.draw do
  resources :questions

  #Call the resources method and pass it a symbol that instructs Rails
  #to create post routes for creating, updating, viewing and deleting
  #instances of Post
  resources :posts

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
