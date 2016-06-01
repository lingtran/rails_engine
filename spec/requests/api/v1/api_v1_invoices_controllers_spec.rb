require 'rails_helper'

RSpec.describe "Api::V1::InvoicesController", type: :request do
  describe "GET index" do
    before(:each) do
      create_list(:invoice, 2)
      get '/api/v1/invoices'
    end

    it "returns an index response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns invoice records" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET show" do
    before(:each) do
      @invoice = create(:invoice)
      id = @invoice.id
      get "/api/v1/invoices/#{id}"
    end

    it "returns a show response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single invoice record" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:status]).to eq(@invoice.status)
    end
  end

  describe "GET find" do
    before(:each) do
      @invoice_one, @invoice_two = create_list(:invoice, 2)
      @status = @invoice_one.status
      get "/api/v1/invoices/find?status=#{@status}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single invoice record found by name" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:status]).to eq(@invoice_one.status)
    end
  end

  describe "GET find_all" do
    before(:each) do
      @customer_id = create(:customer).id
      @invoice_one, @invoice_two = create_list(:invoice, 2, customer_id: @customer_id)
      get "/api/v1/invoices/find_all?customer_id=#{@customer_id}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoice records found by customer" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET random" do
    before(:each) do
      @invoices= create_list(:invoice, 2)
      get "/api/v1/invoices/random"
    end

    it "returns a random response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
      expect(response_body.class).to eq(Hash)
    end
  end

  describe "GET transactions" do
    before(:each) do
      @invoice = create(:invoice)
      @transaction_one, @transaction_two = create_list(:transaction, 2, invoice_id: @invoice.id)
      id = @invoice.id
      get "/api/v1/invoices/#{id}/transactions"
    end

    it "returns a invoice transactions response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoice transactions" do
      expect(response_body.count).to eq(2)
      expect(response_body.first[:id]).to eq(@transaction_one.id)
      expect(response_body.last[:id]).to eq(@transaction_two.id)
    end
  end

  describe "GET invoice items" do
    before(:each) do
      @invoice = create(:invoice)
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2, invoice_id: @invoice.id)
      id = @invoice.id
      get "/api/v1/invoices/#{id}/invoice_items"
    end

    it "returns a invoice items response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoice items for invoice" do
      expect(response_body.count).to eq(2)
      expect(response_body.first[:invoice_id]).to eq(@invoice_item_one.invoice.id)
      expect(response_body.last[:invoice_id]).to eq(@invoice_item_two.invoice.id)
    end
  end

  describe "GET items" do
    before(:each) do
      @invoice = create(:invoice)
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2, invoice_id: @invoice.id)
      @item_one, @item_two = create_list(:item, 2)
      @invoice_item_one.item = @item_one
      @invoice_item_two.item = @item_two
      id = @invoice.id
      get "/api/v1/invoices/#{id}/items"
    end

    it "returns a items response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of items for invoice" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET customer" do
    before(:each) do
      @customer = create(:customer)
      @invoice = create(:invoice, customer_id: @customer.id)
      id = @invoice.id
      get "/api/v1/invoices/#{id}/customer"
    end

    it "returns a customer response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single customer for invoice" do
      expect(response_body[:first_name]).to eq(@customer.first_name)
    end
  end

  describe "GET merchant" do
    before(:each) do
      @merchant = create(:merchant)
      @invoice = create(:invoice, merchant_id: @merchant.id)
      id = @invoice.id
      get "/api/v1/invoices/#{id}/merchant"
    end

    it "returns a merchant response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single merchant for invoice" do
      expect(response_body[:name]).to eq(@merchant.name)
    end
  end
end
