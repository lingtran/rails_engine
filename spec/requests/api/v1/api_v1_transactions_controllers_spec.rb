require 'rails_helper'

RSpec.describe "Api::V1::TransactionsController", type: :request do
  describe "GET index" do
    before(:each) do
      create_list(:transaction, 2)
      get '/api/v1/transactions'
    end

    it "returns an index response" do

      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns transaction records" do
      expect(response_body.count).to eq(2)
    end
  end

  describe "GET show" do
    before(:each) do
      @transaction = create(:transaction)
      id = @transaction.id
      get "/api/v1/transactions/#{id}"
    end

    it "returns a show response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single transaction record" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:credit_card_number]).to eq(@transaction.credit_card_number)
    end
  end

  describe "GET find" do
    before(:each) do
      @transaction_one, @transaction_two = create_list(:transaction, 2)
      @credit_card_number = @transaction_one.credit_card_number
      get "/api/v1/transactions/find?credit_card_number=#{@credit_card_number}"
    end

    it "returns a find response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a single transaction record found by credit card number" do
      expect(response_body[:id]).to eq(1)
      expect(response_body[:credit_card_number]).to eq(@credit_card_number)
    end
  end

  describe "GET find_all" do
    before(:each) do
      @transaction_one, @transaction_two = create_list(:transaction, 2)
      @credit_card_number = @transaction_one.credit_card_number
      get "/api/v1/transactions/find_all?credit_card_number=#{@credit_card_number}"
    end

    it "returns a find_all response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end

    it "returns a collection of transaction records found by credit card number" do
      expect(response_body.first[:id]).to eq(1)
      expect(response_body.count).to eq(1)
    end
  end

  describe "GET random" do
    before(:each) do
      @transactions= create_list(:transaction, 2)
      get "/api/v1/transactions/random"
    end

    it "returns a random response" do
      expect(response).to have_http_status(200)
      expect(response).to be_success
      expect(response_body.class).to eq(Hash)
    end
  end
end
