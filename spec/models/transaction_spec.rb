require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:invoice_id) }
    it { is_expected.to validate_presence_of(:credit_card_number) }
    it { is_expected.not_to validate_presence_of(:credit_card_expiration_date) }
    it { is_expected.to validate_presence_of(:result) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should belong_to(:invoice) }
    it { should respond_to(:customer) }

    it "returns associated customer record" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)

      expect(transaction.customer).to eq(customer)
    end
  end

  context "single finder" do
    before(:each) do
      @transaction = create(:transaction, result: "success", credit_card_number: "4654405418249632")
    end

    it "returns a single transaction records for case insensitive search by result" do
      first_params = { result: "SUCCESS" }
      not_result_attr = { result: "Failed" }
      first_result = Transaction.search_by(first_params)
      nil_result = Transaction.search_by(not_result_attr)

      expect(first_result).to eq(@transaction)
      expect(nil_result).to eq(nil)
    end

    it "returns a single transaction for other searches" do
      params = { credit_card_number: "4654405418249632" }
      not_number = { credit_card_number: "4140149827486249"}
      result = Transaction.search_by(params)
      nil_result = Transaction.search_by(not_number)

      expect(result).to eq(@transaction)
      expect(nil_result).to eq(nil)
    end
  end

  context "multi finder" do
    before(:each) do
      @transaction = create(:transaction, result: "success", credit_card_number: "4654405418249632")
    end

    it "returns an array of transaction records for case insensitive search by result" do
      first_params = { result: "SUCCESS" }
      second_params = { result: "Failed" }
      first_result = Transaction.find_all(first_params)
      second_result = Transaction.find_all(second_params)

      expect(first_result).to eq([@transaction])
      expect(second_result).to eq([])
    end

    it "returns an array of transaction records for credit_card_number" do
      params = { credit_card_number: "4654405418249632" }
      not_number = { credit_card_number: "4140149827486249"}
      result = Transaction.find_all(params)
      nil_result = Transaction.find_all(not_number)

      expect(result).to eq([@transaction])
      expect(nil_result).to eq([])
    end

    it "returns an array of transaction records for id" do
      params = { id: 1 }
      result = Transaction.find_all(params)

      expect(result).to eq([@transaction])
      expect(result.length).to eq(1)
    end
  end

  context "#rand" do
    it "returns a random transaction record" do
      transaction_one, transaction_two = create_list(:transaction, 2)
      random_transaction = Transaction.rand

      expect(random_transaction).not_to eq(transaction_one) if random_transaction == transaction_two
    end
  end
end
