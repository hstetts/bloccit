require 'rails_helper'

RSpec.describe Topic, type: :model do
 let(:topic) { create(:topic) }
 let(:public) { true }


 it { is_expected.to have_many(:posts) }

 #confirm a topic responds to the appropriate attributes
 describe "attributes" do
   it "has name, description, and public attributes" do
     expect(topic).to have_attributes(name: topic.name, description: topic.description)
   end

   #confirm public attribute is set to true by default
   it "is public by default" do
     expect(topic.public).to be(true)
   end
 end
end
