require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do

     let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

     let(:sponsored_post) { topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_integer) }

     it { is_expected.to belong_to(:topic) }

    describe "attributes" do
      it "has title and body attributes" do
        expect(sponsored_post).to have_attributes(title: title, body: body)
      end

      it "has price attributes" do
        expect(sponsored_post).to have_attributes(price: price)
      end

    end
  end
