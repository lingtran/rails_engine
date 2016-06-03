require 'rails_helper'

RSpec.describe "Api::V1::Merchant::RevenueController", type: :request do
  describe "GET revenue" do
    before(:each) do
      load_associations
      id = 2

      get "/api/v1/merchants/#{id}/revenue"
    end

    it "returns a revenue response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns the total revenue for merchant across all transactions" do
      expect(response_body.count).to eq(1)

      expect(response_body).to eq({:revenue=>"3.0"})
    end
  end
end
