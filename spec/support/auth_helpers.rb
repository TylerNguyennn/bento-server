module AuthHelpers
  def auth_headers(user)
    post "/login", params: {
      user: {
        email: user.email,
        password: "password123"
      }
    }.to_json, headers: { "Content-Type" => "application/json" }

    { "Authorization" => response.headers["Authorization"], "Content-Type" => "application/json" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end
