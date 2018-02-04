Rails.application.routes.draw do

  resources :topics do
     #pass resources :posts to the resources :topics block
     #this nests the post routes under the topic routes
     resources :posts, except: [:index]
     resources :sponsored_posts, except: [:index]
  end


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
