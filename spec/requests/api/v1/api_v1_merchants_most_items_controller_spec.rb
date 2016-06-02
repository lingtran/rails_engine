require 'rails_helper'

RSpec.describe "Api::V1::Merchants::MostItemsController", type: :request do
  describe "GET most items" do
    before(:each) do
      load_associations
      x = 1
      get "/api/v1/merchants/most_items?quantity=#{x}"
    end

    it "returns a most items response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns the top x merchants ranked by total number of items sold" do
      expect(response_body.count).to eq(1)
      expect(response_body.first[:name]).to eq(merchant_two.name)
    end
  end
end
