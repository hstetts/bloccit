Rails.application.routes.draw do
  resources :topics do
     #pass resources :posts to the resources :topics block
     #this nests the post routes under the topic routes
     resources :posts, except: [:index]
  end

  #use only: [] because we don't want to create any /posts/:id routes, just posts/:post_id/comments routes.
  resources :posts, only: [] do
     #only add create and destroy routes for comments.
     #We'll display comments on the posts show view, so we won't need index or new routes.
     resources :comments, only: [:create, :destroy]
     post '/up-vote' => 'votes#up_vote', as: :up_vote
     post '/down-vote' => 'votes#down_vote', as: :down_vote
     resources :favorites, only: [:create, :destroy]
  end

  #create routes for new and create actions.
  #Only hash key will prevent Rails from creating unnecessary routes.
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
