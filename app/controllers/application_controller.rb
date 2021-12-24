class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for User
  skip_before_action :verify_authenticity_token
end
