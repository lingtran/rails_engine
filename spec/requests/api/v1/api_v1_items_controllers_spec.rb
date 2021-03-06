require 'rails_helper'

RSpec.describe "Api::V1::ItemsController", type: :request do
  describe "GET index" do
    before(:each) do
      create_list(:item, 2)
      get '/api/v1/items'
    end

    it "returns an index response" do

      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns item records" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET show" do
    before(:each) do
      @item = create(:item)
      id = @item.id
      get "/api/v1/items/#{id}"
    end

    it "returns a show response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single item record" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:name]).to eq(@item.name)
    end
  end

  describe "GET find for name" do
    before(:each) do
      @item_one, @item_two = create_list(:item, 2)
      @name = @item_one.name
      get "/api/v1/items/find?name=#{@name}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single item record found by name" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:name]).to eq(@name)
    end
  end

  describe "GET find for unit price" do
    before(:each) do
      @item_one, @item_two = create_list(:item, 2)
      unit_price = "1.00"
      get "/api/v1/items/find?unit_price=#{unit_price}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single item record found by name" do
      expect(response_body[:id]).to eq(1)
    end
  end

  describe "GET find_all for name" do
    before(:each) do
      @item_one, @item_two = create_list(:item, 2)
      @name = @item_one.name
      get "/api/v1/items/find_all?name=#{@name}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of item records found by name" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.count).to eq(1)
    end
  end

  describe "GET find_all for unit price" do
    before(:each) do
      @item_one, @item_two = create_list(:item, 2)
      unit_price = "1.00"
      get "/api/v1/items/find_all?unit_price=#{unit_price}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of item records found by unit price" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET random" do
    before(:each) do
      @items= create_list(:item, 2)
      get "/api/v1/items/random"
    end

    it "returns a random response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
      expect(response_body.class).to eq(Hash)
    end
  end

  describe "GET invoice_items" do
    before(:each) do
      @item = create(:item)
      id = @item.id
      @invoice_item_one, @invoice_item_two = create_list(:invoice_item, 2, item_id: @item.id)
      get "/api/v1/items/#{id}/invoice_items"
    end

    it "returns an invoice_items response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoice items for item" do
      expect(response_body.count).to eq(2)
      expect(response_body.last[:id]).to eq(@item.invoice_items.last.id)
    end
  end

  describe "GET merchant" do
    before(:each) do
      @merchant = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id)
      id = @item.id
      get "/api/v1/items/#{id}/merchant"
    end

    it "returns a merchant response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a merchant for item" do
      expect(response_body[:id]).to eq(@item.merchant.id)
    end
  end
end
