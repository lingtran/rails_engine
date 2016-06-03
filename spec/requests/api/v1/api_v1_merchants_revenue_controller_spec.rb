require 'rails_helper'

RSpec.describe "Api::V1::Merchants::RevenueController", type: :request do
  describe "GET revenue" do
    before(:each) do
      load_associations
      x = "2012-03-27 14:53:59"

      get "/api/v1/merchants/revenue?date=#{x}"
    end

    it "returns a revenue response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns the total revenue for date x across all merchants" do
      expect(response_body.count).to eq(1)

      expect(response_body).to eq({:total_revenue=>"4.0"})
    end
  end
end
