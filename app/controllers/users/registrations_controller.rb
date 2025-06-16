class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :configure_sign_up_params, only: [:create]
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save

    if resource.persisted?

      if params[:user][:role].present?
        role_name = params.dig(:user, :role) || 'buyer'
        role = Role.find_by(name: role_name)
        resource.roles << role if role
      end

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