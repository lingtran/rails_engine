require 'rails_helper'

RSpec.describe "Api::V1::Merchant::FavoriteCustomerController", type: :request do
  describe "GET favorite customer" do
    before(:each) do
      load_associations
      id = 1

      get "/api/v1/merchants/#{id}/favorite_customer"
    end

    it "returns a favorite customer response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns the customer who has conducted the most total number of successful transactions" do
      expect(response_body[:id]).to eq(customer_one.id)
      expect(response_body[:id]).not_to eq(customer_two.id)
    end
  end

end
