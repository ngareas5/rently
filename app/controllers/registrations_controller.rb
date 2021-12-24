class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)
    if user.save
      render :json=> user.as_json, :status=>201
    else
      render :json=> user.errors, :status=>422
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation  )
  end
end
