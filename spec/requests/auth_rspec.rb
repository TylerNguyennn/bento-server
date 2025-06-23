require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:headers) { { "Content-Type" => "application/json" } }

  describe "POST /signup" do
    it "registers a new user" do
      params = {
        user: {
          first_name: "Alice",
          last_name: "Nguyen",
          email: "alice@example.com",
          password: "password123",
          role: "buyer"
        }
      }

      post "/signup", params: params.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["email"]).to eq("alice@example.com")
    end
  end

  describe "POST /login" do
    let!(:user) { create(:user, email: "bob@example.com", password: "password123") }

    it "logs in successfully and returns JWT" do
      params = {
        user: {
          email: "bob@example.com",
          password: "password123"
        }
      }

      post "/login", params: params.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.headers["Authorization"]).to be_present
    end

    it "fails with wrong credentials" do
      params = {
        user: {
          email: "bob@example.com",
          password: "wrongpass"
        }
      }

      post "/login", params: params.to_json, headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /logout" do
    let!(:user) { create(:user, password: "password123") }

    it "logs out user with valid JWT" do
      post "/login", params: {
        user: {
          email: user.email,
          password: "password123"
        }
      }.to_json, headers: headers

      token = response.headers["Authorization"]
      expect(token).to be_present

      delete "/logout", headers: headers.merge({ "Authorization" => token })

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("logged out successfully")
    end
  end
end
