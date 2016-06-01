require 'rails_helper'

RSpec.describe "Api::V1::MerchantsController", type: :request do
  describe "GET index" do
    before(:each) do
      create_list(:merchant, 2)
      get '/api/v1/merchants'
    end

    it "returns an index response" do

      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns merchant records" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET show" do
    before(:each) do
      @merchant = create(:merchant)
      id = @merchant.id
      get "/api/v1/merchants/#{id}"
    end

    it "returns a show response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single merchant record" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:name]).to eq(@merchant.name)
    end
  end

  describe "GET find" do
    before(:each) do
      @merchant_one, @merchant_two = create_list(:merchant, 2)
      @name = @merchant_one.name
      get "/api/v1/merchants/find?name=#{@name.upcase}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single merchant record found by name" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:name]).to eq(@name)
    end
  end

  describe "GET find_all" do
    before(:each) do
      @merchant_one, @merchant_two = create_list(:merchant, 2)
      @created_at = @merchant_two.created_at
      get "/api/v1/merchants/find_all?created_at=#{@created_at}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of merchant records found by created_at" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET random" do
    before(:each) do
      @merchants= create_list(:merchant, 2)
      get "/api/v1/merchants/random"
    end

    it "returns a random response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
      expect(response_body.class).to eq(Hash)
    end
  end

  describe "GET items" do
    before(:each) do
      @merchant = create(:merchant)
      @item_one, @item_two = create_list(:item, 2, merchant_id: @merchant.id)
      id = @merchant.id
      get "/api/v1/merchants/#{id}/items"
    end

    it "returns a merchant items response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of merchant items" do
      expect(response_body.count).to eq(2)
      expect(response_body.first[:name]).to eq(@item_one.name)
      expect(response_body.last[:name]).to eq(@item_two.name)
    end
  end

  describe "GET invoices" do
    before(:each) do
      @merchant = create(:merchant)
      @invoice_one, @invoice_two = create_list(:invoice, 2, merchant_id: @merchant.id)
      id = @merchant.id
      get "/api/v1/merchants/#{id}/invoices"
    end

    it "returns a merchant invoices response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of merchant invoices" do
      expect(response_body.count).to eq(2)
      expect(response_body.first[:merchant_id]).to eq(@invoice_one.merchant.id)
      expect(response_body.last[:merchant_id]).to eq(@invoice_two.merchant.id)
    end
  end
end
