class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in(user)
      token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
      render json: { token: token, user: user }
    else
      render json: { error: "OAuth login failed" }, status: :unauthorized
    end
  end
end
