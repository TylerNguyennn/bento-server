# require 'rails_helper'

# RSpec.describe "Products", type: :request do
#   let(:seller) { create(:user, :seller) }
#   let(:buyer) { create(:user, :buyer) }
#   let(:product) { create(:product, seller: seller, published: true) }
#   let(:unpublished_product) { create(:product, seller: seller, published: false) }

#   let(:auth_headers) do
#     seller.create_new_auth_token.merge("Content-Type" => "application/json")
#   end

#   describe "GET /products" do
#     it "allows guest to view all products" do
#       get "/products"
#       expect(response).to have_http_status(:ok)
#     end
#   end

#   describe "GET /products/:id" do
#     it "allows anyone to view published product" do
#       get "/products/#{product.id}"
#       expect(response).to have_http_status(:ok)
#     end

#     it "prevents guest from viewing unpublished product" do
#       get "/products/#{unpublished_product.id}"
#       expect(response).to have_http_status(:not_found)
#     end

#     it "allows owner to view their own unpublished product" do
#       get "/products/#{unpublished_product.id}", headers: auth_headers.call(seller)
#       expect(response).to have_http_status(:ok)
#     end
#   end

#   describe "POST /products" do
#     let(:valid_params) {
#       {
#         product: {
#           title: "New Product",
#           description: "Nice one",
#           price: 50.0,
#           category: "Tech",
#           published: true
#         }
#       }.to_json
#     }

#     it "allows seller to create product" do
#       post "/products", params: valid_params, headers: auth_headers.call(seller)
#       expect(response).to have_http_status(:created)
#     end

#     it "prevents buyer from creating product" do
#       post "/products", params: valid_params, headers: auth_headers.call(buyer)
#       expect(response).to have_http_status(:forbidden)
#     end

#     it "prevents guest from creating product" do
#       post "/products", params: valid_params
#       expect(response).to have_http_status(:unauthorized)
#     end
#   end

#   describe "PATCH /products/:id" do
#     it "allows seller to update their product" do
#       patch "/products/#{product.id}", params: { product: { title: "Updated" } }.to_json, headers: auth_headers.call(seller)
#       expect(response).to have_http_status(:ok)
#       expect(JSON.parse(response.body)["title"]).to eq("Updated")
#     end

#     it "prevents seller from updating someone else's product" do
#       other_seller = create(:user, :seller)
#       patch "/products/#{product.id}", params: { product: { title: "Hack" } }.to_json, headers: auth_headers.call(other_seller)
#       expect(response).to have_http_status(:unauthorized)
#     end
#   end

#   describe "DELETE /products/:id" do
#     it "allows owner to delete their product" do
#       delete "/products/#{product.id}", headers: auth_headers.call(seller)
#       expect(response).to have_http_status(:ok)
#     end

#     it "prevents others from deleting product" do
#       delete "/products/#{product.id}", headers: auth_headers.call(buyer)
#       expect(response).to have_http_status(:unauthorized)
#     end
#   end
# end
