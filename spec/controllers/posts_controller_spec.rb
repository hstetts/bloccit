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

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
