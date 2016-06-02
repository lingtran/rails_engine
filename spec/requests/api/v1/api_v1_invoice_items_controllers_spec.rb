require 'rails_helper'

RSpec.describe "Api::V1::InvoiceItemsController", type: :request do
  describe "GET index" do
    before(:each) do
      create_list(:invoice_item, 2)
      get '/api/v1/invoice_items'
    end

    it "returns an index response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns invoice items records" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET show" do
    before(:each) do
      @invoice_item = create(:invoice_item)
      id = @invoice_item.id
      get "/api/v1/invoice_items/#{id}"
    end

    it "returns a show response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single invoice item record" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:quantity]).to eq(@invoice_item.quantity)
    end
  end

  describe "GET find by quantity" do
    before(:each) do
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2)
      @quantity = @invoice_item_one.quantity
      get "/api/v1/invoice_items/find?quantity=#{@quantity}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single invoice record found by quantity" do
      expect(response_body[:id]).to eq(1)
    end
  end

  describe "GET find_all" do
    before(:each) do
      @invoice_id = create(:invoice).id
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2, invoice_id: @invoice_id)
      get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_id}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoice items records found by invoice" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.class).to eq(Array)
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET find by unit price" do
    before(:each) do
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2)
      unit_price = "1.00"
      get "/api/v1/invoice_items/find?unit_price=#{unit_price}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single invoice record found by unit price" do
      expect(response_body[:id]).to eq(1)
    end
  end

  describe "GET find_all by unit price" do
    before(:each) do
      invoice_id = create(:invoice).id
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2, invoice_id: invoice_id)
      unit_price = "1.00"
      get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoice items records found by unit price" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.class).to eq(Array)
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET random" do
    before(:each) do
      create_list(:invoice_item, 2)
      get "/api/v1/invoice_items/random"
    end

    it "returns a random response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
      expect(response_body.class).to eq(Hash)
    end
  end

  describe "GET invoice" do
    before(:each) do
      @invoice = create(:invoice)
      id = @invoice.id
      @invoice_item = create(:invoice_item, invoice_id: id)
      get "/api/v1/invoice_items/#{id}/invoice"
    end

    it "returns an invoice response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a record of invoice for invoice item" do
      expect(response_body[:id]).to eq(@invoice_item.invoice_id)
    end
  end

  describe "GET item" do
    before(:each) do
      @item = create(:item)
      id = @item.id
      @invoice_item = create(:invoice_item, item_id: id)
      get "/api/v1/invoice_items/#{id}/item"
    end

    it "returns an item response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a record of item for invoice item" do
      expect(response_body[:id]).to eq(@invoice_item.invoice_id)
    end
  end
end
