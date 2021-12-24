require 'spec_helper'
require 'rails_helper'
RSpec.describe CommentsController, :type => :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user_id: @user.id)		
    @headers = {
      "X-USER-TOKEN" => @user.authentication_token,
      "X-USER-EMAIL" => @user.email
    }
  end

  describe "#create" do

    context "with correct payload" do

      it "has the correct details" do
        post '/comments', params: {content:"demo comment", post_id:@post.id}, headers: @headers
        response = JSON.parse(response.body)
        expect(response).to have_http_status 201
      end
    end
  end
end
