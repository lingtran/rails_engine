require 'rails_helper'

RSpec.describe "Api::V1::CustomersController", type: :request do
  describe "GET index" do
    before(:each) do
      create_list(:customer, 2)
      get '/api/v1/customers'
    end

    it "returns an index response" do

      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns customer records" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET show" do
    before(:each) do
      @customer = create(:customer)
      id = @customer.id
      get "/api/v1/customers/#{id}"
    end

    it "returns a show response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single customer record" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:first_name]).to eq(@customer.first_name)
    end
  end

  describe "GET find" do
    before(:each) do
      @customer_one, @customer_two = create_list(:customer, 2)
      @first_name = @customer_one.first_name
      get "/api/v1/customers/find?name=#{@first_name.upcase}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single customer record found by name" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:first_name]).to eq(@first_name)
    end
  end

  describe "GET find_all" do
    before(:each) do
      @customer_one, @customer_two = create_list(:customer, 2)
      @first_name = @customer_two.first_name
      get "/api/v1/customers/find_all?first_name=#{@first_name}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of customer records found by created_at" do
      expect(response_body.first[:id]).to eq(2)
      expect(response_body.count).to eq(1)
    end
  end

  describe "GET random" do
    before(:each) do
      @customers= create_list(:customer, 2)
      get "/api/v1/customers/random"
    end

    it "returns a random response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
      expect(response_body.class).to eq(Hash)
    end
  end

  describe "GET invoices" do
    before(:each) do
      @customer = create(:customer)
      id = @customer.id
      create_list(:invoice, 2, customer_id: id)
      get "/api/v1/customers/#{id}/invoices"
    end

    it "returns an invoices response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of invoices for customer" do
      expect(response_body.count).to eq(2)
      expect(response_body.first[:id]).to eq(@customer.invoices.first.id)
    end
  end
end
