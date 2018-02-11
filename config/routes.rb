Rails.application.routes.draw do
  resources :topics do
     #pass resources :posts to the resources :topics block
     #this nests the post routes under the topic routes
     resources :posts, except: [:index]
  end
  #create routes for new and create actions.
  #Only hash key will prevent Rails from creating unnecessary routes.
  resources :users, only: [:new, :create]


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
