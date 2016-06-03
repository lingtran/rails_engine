require 'rails_helper'

RSpec.describe "Api::V1::Items::MostRevenueController", type: :request do
  describe "GET most revenue" do
    before(:each) do
      load_associations
      x = 1

      get "/api/v1/items/most_revenue?quantity=#{x}"
    end

    it "returns a most revenue response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns the top x items ranked by total revenue generated" do
      expect(response_body.count).to eq(1)
      expect(response_body.first[:name]).to eq(item_two.name)
    end
  end
end
