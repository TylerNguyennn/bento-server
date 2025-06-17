class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :configure_sign_up_params, only: [:create]
  respond_to :json

  def create
    role_name = params.dig(:user, :role)&.downcase || 'buyer'

    unless %w[buyer seller].include?(role_name)
      return render json: { error: "Invalid role" }, status: :forbidden
    end

    build_resource(sign_up_params)

    if resource.save
      role = Role.find_by(name: role_name)
      resource.roles << role if role
      sign_up(resource_name, resource)
    end

    respond_with resource
  end


  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up sucessfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end