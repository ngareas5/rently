require 'spec_helper'
require 'rails_helper'
RSpec.describe RegistrationsController, :type => :request do

  describe "#create" do

    context "with correct payload" do
        request_body = {
          user: {
            email: 'John@gmail.com',
            password: 'pass123456',
            password_confirmation: 'pass123456'
          }
        }   
      it "has the correct details" do
        post '/users', params: request_body
        @body = JSON.parse(response.body)
        @body["email"].should == 'john@gmail.com'
        @body["id"].should == 1
      end
    end
  end
end
