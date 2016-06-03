require 'rails_helper'

RSpec.describe "Api::V1::Merchant::CustomersWithPendingInvoicesController", type: :request do
  describe "GET customers with pending invoices" do
    before(:each) do
      load_associations
      id = 1
      get "/api/v1/merchants/#{id}/customers_with_pending_invoices"
    end

    it "returns a customers with pending invoices response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of customers which have pending (unpaid) invoices" do
      expect(response_body.count).to eq(1)
      expect(response_body.first[:id]).to eq(customer_two.id)
      expect(response_body).not_to include([customer_one])
    end
  end
end
