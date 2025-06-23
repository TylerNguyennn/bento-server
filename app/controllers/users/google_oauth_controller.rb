class Users::GoogleOauthController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    id_token = params[:id_token]
    validator = GoogleIDToken::Validator.new

    begin
      payload = validator.check(id_token, ENV["GOOGLE_CLIENT_ID"])

      # Extract user info
      email = payload["email"]
      uid = payload["sub"]
      provider = "google_oauth2"
      first_name = payload["given_name"]
      last_name = payload["family_name"]

      user = User.find_or_initialize_by(email: email)

      if user.new_record?
        user.assign_attributes(
          uid: uid,
          provider: provider,
          first_name: first_name,
          last_name: last_name,
          password: Devise.friendly_token[0, 20],
          confirmed_at: Time.current
        )
        user.save!

        # Assign default role (optional)
        role = Role.find_by(name: "buyer")
        user.roles << role if role
      else
        if user.provider != provider || user.uid != uid
          user.update(provider: provider, uid: uid)
        end
        user.confirm unless user.confirmed?
      end

      sign_in(user)
      token = request.env["warden-jwt_auth.token"]

      render json: {
        status: { code: 200, message: "Signed in successfully with Google." },
        data: UserSerializer.new(user).serializable_hash[:data][:attributes],
        jwt: token
      }

    rescue GoogleIDToken::ValidationError => e
      render json: { error: "Invalid Google token", details: e.message }, status: :unauthorized
    rescue => e
      render json: { error: "Authentication failed", details: e.message }, status: :unprocessable_entity
    end
  end
end
