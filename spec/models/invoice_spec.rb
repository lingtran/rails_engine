require 'rails_helper'

RSpec.describe Invoice, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:customer_id) }
    it { is_expected.to validate_presence_of(:merchant_id) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  context "single finder" do
    before(:each) do
      @invoice = create(:invoice)
    end

    it "returns a single invoice record for case insensitive search by result" do
      first_params = { status: "SHIPPED" }
      not_result_attr = { status: "pending" }
      first_result = Invoice.search_by(first_params)
      nil_result = Invoice.search_by(not_result_attr)

      expect(first_result).to eq(@invoice)
      expect(nil_result).to eq(nil)
    end

    it "returns a single invoice record for other searches" do
      params = { customer_id: 1 }
      not_number = { customer_id: 2 }
      result = Invoice.search_by(params)
      nil_result = Invoice.search_by(not_number)

      expect(result).to eq(@invoice)
      expect(nil_result).to eq(nil)
    end
  end

  context "multi finder" do
    before(:each) do
      @invoice = create(:invoice)
    end

    it "returns an array of invoice records for case insensitive search by result" do
      first_params = { status: "SHIPPED" }
      not_result_attr = { status: "pending" }
      first_result = Invoice.find_all(first_params)
      nil_result = Invoice.find_all(not_result_attr)

      expect(first_result).to eq([@invoice])
      expect(nil_result).to eq([])
    end

    it "returns an array of invoice records for other searches" do
      params = { customer_id: 1 }
      not_number = { customer_id: 2 }
      result = Invoice.find_all(params)
      nil_result = Invoice.find_all(not_number)

      expect(result).to eq([@invoice])
      expect(nil_result).to eq([])
    end
  end

  context "#rand" do
    it "returns a random transaction record" do
      invoice_one, invoice_two = create_list(:invoice, 2)
      random_invoice = Invoice.rand

      expect(random_invoice).not_to eq(invoice_one) if random_invoice == invoice_two
    end
  end

  context "relationship endpoints" do
    before(:each) do
      @invoice = create(:invoice)
    end

    it "returns a collection of associated transactions" do
      queried_transactions_for_invoice = Invoice.find(@invoice.id).transactions
      transaction_method = Invoice.has_transactions(@invoice.id)

      expect(transaction_method).to eq(queried_transactions_for_invoice)
    end

    it "returns a collection of associated invoice items" do
      queried_invoice_items_for_invoice = Invoice.find(@invoice.id).invoice_items
      invoice_item_method = Invoice.has_invoice_items(@invoice.id)

      expect(invoice_item_method).to eq(queried_invoice_items_for_invoice)
    end

    it "returns a collection of associated items" do
      queried_items_for_invoice = Invoice.find(@invoice.id).items
      item_method = Invoice.has_items(@invoice.id)

      expect(item_method).to eq(queried_items_for_invoice)
    end

    it "returns the associated customer" do
      queried_customer_for_invoice = Invoice.find(@invoice.id).customer
      customer_method = Invoice.has_customer(@invoice.id)

      expect(customer_method).to eq(queried_customer_for_invoice)
    end

    it "returns the associated merchant" do
      queried_merchant_for_invoice = Invoice.find(@invoice.id).merchant
      merchant_method = Invoice.has_merchant(@invoice.id)

      expect(merchant_method).to eq(queried_merchant_for_invoice)
    end
  end

end
