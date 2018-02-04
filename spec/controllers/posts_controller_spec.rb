require 'rails_helper'

#type: :controller tells RSPec to treat this as a controller test
RSpec.describe PostsController, type: :controller do
#create a post and assign it to my_post using let
#use RandomData to give my_post a random title and body
#create a parent topic named my_topic
let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
#update how we create my_post so it will belong to my_topic
let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }



describe "GET show" do
  it "returns http success" do
   #we pass {id: my_post.id} to show as a parameter. These parameters are passed to the  params hash.
   #updated: update get show request to include id of parent topic
   get :show, params: { topic_id: my_topic.id, id: my_post.id }
   expect(response).to have_http_status(:success)
  end
  it "renders the #show view" do
   #expect the response to return the show view using the render_template matcher.
   get :show, params: { topic_id: my_topic.id, id: my_post.id }
   expect(response).to render_template :show
  end

  it "assigns my_post to @post" do
   get :show, params: { topic_id: my_topic.id, id: my_post.id }
   #expect the post to equal my_post because we call show with the id of my_post. We are testing that the post returned to us is the post we asked for.
   expect(assigns(:post)).to eq(my_post)
  end
end


#when new is invoked, a new and unsaved Post object is created
#GET so does not create data
describe "GET new" do
  it "returns http success" do
   get :new, params: { topic_id: my_topic.id }
   expect(response).to have_http_status(:success)
  end

  #expect PostsController#new to render the posts new view.
  #use the render_template method to verify the correct template view is rendered
  it "renders the #new view" do
   get :new, params: { topic_id: my_topic.id }
   expect(response).to render_template :new
  end

  #expect @post to be initialized by PostsController#new.
  #assigns gives us access to the @post variable, assigning it to :post
  it "instantiates @post" do
   get :new, params: { topic_id: my_topic.id }
   expect(assigns(:post)).not_to be_nil
  end
end

describe "POST create" do
  #unlike new, the newly created object is persisted in DB
  #after PostsController#create is called w/ parameters, the count of Post instances in the DB will increase by one
  it "increases the number of Post by 1" do
    expect {
      post :create, params: {
        topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      }.to change(Post,:count).by(1)
  end

  #when create is POSTed, we expect the newly created post to be assigned to @post
  it "assigns the new post to @post" do
   post :create, params: {
     topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph }
   }
   expect(assigns(:post)).to eq Post.last
  end

  #expect to be redirected to the newly created post
  it "redirects to the new post" do
    post :create, params: {
       topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph }
     }
    #updated: bc route for the posts show view will also be updated to reflect nested posts,
    #we redirect to [my_topic, Post.last] instead of Post.last
    expect(response).to redirect_to [my_topic, Post.last]
  end
end

describe "GET edit" do
  it "returns http success" do
   get :edit, params: { topic_id: my_topic.id, id: my_post.id }
   expect(response).to have_http_status(:success)
  end

  it "renders the #edit view" do
   get :edit, params: { topic_id: my_topic.id, id: my_post.id }
   #expect edit view to render when a post is edited
   expect(response).to render_template :edit
  end

  #test edit assigned the correct post to be updated to @post
  it "assigns post to be updated to @post" do
   get :edit, params: { topic_id: my_topic.id, id: my_post.id }

   post_instance = assigns(:post)

   expect(post_instance.id).to eq my_post.id
   expect(post_instance.title).to eq my_post.title
   expect(post_instance.body).to eq my_post.body
  end
end

describe "PUT update" do
  it "updates post with expected attributes" do
   new_title = RandomData.random_sentence
   new_body = RandomData.random_paragraph

   put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }

   #test that @post was updated with the title and body passed to update
   #We also test that @post's id was not changed.
   updated_post = assigns(:post)
   expect(updated_post.id).to eq my_post.id
   expect(updated_post.title).to eq new_title
   expect(updated_post.body).to eq new_body
  end

  it "redirects to the updated post" do
   new_title = RandomData.random_sentence
   new_body = RandomData.random_paragraph

   #expect to be redirected to the posts show view after update
   put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }
   #replace redirect_to my_post with redirect_to [my_topic, my_post] so we'll be redirected to the posts show view after nest posts
   expect(response).to redirect_to [my_topic, my_post]
  end
 end

 describe "DELETE destroy" do
   it "deletes the post" do
    delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
    #search db for a post with an id equal to my_post.id
    #returns an array
    #assign the size of the array to count, expect count to = 0
    count = Post.where({id: my_post.id}).size
    expect(count).to eq 0
   end

   it "redirects to topic show" do

    delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }

    expect(response).to redirect_to my_topic
   end
 end
end
