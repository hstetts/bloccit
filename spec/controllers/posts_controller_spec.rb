require 'rails_helper'

#type: :controller tells RSPec to treat this as a controller test
RSpec.describe PostsController, type: :controller do
#create a post and assign it to my_post using let
#use RandomData to give my_post a random title and body
let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

describe "GET #index" do
  it "returns http success" do

    #test performs a GET on the index view and expects successful response
    get :index
    expect(response).to have_http_status(:success)
  end

  it "assigns [my_post] to @posts" do
     get :index
     #we expect index to return an array of one item
     #assigns gives the test access to instance variables assigned
     #in the action that are available for the view
     expect(assigns(:posts)).to eq([my_post])
   end
 end

#commented out bc won't write the implementation until later

describe "GET show" do
 it "returns http success" do
   #we pass {id: my_post.id} to show as a parameter. These parameters are passed to the  params hash.
   get :show, params: { id: my_post.id }
   expect(response).to have_http_status(:success)
 end
 it "renders the #show view" do
   #expect the response to return the show view using the render_template matcher.
   get :show, params: { id: my_post.id }
   expect(response).to render_template :show
 end

 it "assigns my_post to @post" do
   get :show, params: { id: my_post.id }
   #expect the post to equal my_post because we call show with the id of my_post. We are testing that the post returned to us is the post we asked for.
   expect(assigns(:post)).to eq(my_post)
 end
   end


#when new is invoked, a new and unsaved Post object is created
#GET so does not create data
describe "GET new" do
 it "returns http success" do
   get :new
   expect(response).to have_http_status(:success)
 end

 #expect PostsController#new to render the posts new view.
 #use the render_template method to verify the correct template view is rendered
 it "renders the #new view" do
   get :new
   expect(response).to render_template :new
 end

 #expect @post to be initialized by PostsController#new.
 #assigns gives us access to the @post variable, assigning it to :post
 it "instantiates @post" do
   get :new
   expect(assigns(:post)).not_to be_nil
 end
end

describe "POST create" do
#unlike new, the newly created object is persisted in DB
#after PostsController#create is called w/ parameters, the count of Post instances in the DB will increase by one
 it "increases the number of Post by 1" do
   expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
 end

 #when create is POSTed, we expect the newly created post to be assigned to @post
 it "assigns the new post to @post" do
   post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
   expect(assigns(:post)).to eq Post.last
 end

 #expect to be redirected to the newly created post
 it "redirects to the new post" do
   post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
   expect(response).to redirect_to Post.last
 end
end
#
# describe "GET #edit" do
#   it "returns http success" do
#     get :edit
#     expect(response).to have_http_status(:success)
#   end
# end

end
