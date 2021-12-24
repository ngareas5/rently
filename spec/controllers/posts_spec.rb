require 'spec_helper'
require 'rails_helper'
RSpec.describe PostsController, :type => :request do
  before do
    @user = FactoryBot.create(:user)	
    @headers = {
      "X-USER-TOKEN" => @user.authentication_token,
      "X-USER-EMAIL" => @user.email
    }
  end

  describe "#create" do

    context "with correct payload" do

      it "has the correct details" do
        post '/posts', params: {content:"demo post"}, headers: @headers
        response = JSON.parse(response.body)
        expect(response).to have_http_status 201
      end
    end
  end

  describe "#show" do

    describe 'show posts and its comment' do
      before do
        @post = FactoryBot.create(:post, user_id: @user.id)	
        get '/posts/'+ @post.id.to_s, headers: @headers
      end

      it { response.status.should == 200 }

      it "should retrieve the correct post" do
        response = JSON.parse(response.body)
        response["id"].should == @post.id
        #response[""].should == @post
      end
    end
  end
end
