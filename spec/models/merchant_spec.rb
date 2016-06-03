require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  context "single finder" do
    before(:each) do
      @merchant = create(:merchant, name: "Cobbler")
    end

    it "returns a single merchant record for case insensitive search by result" do
      first_params = { name: "CoBBLer" }
      not_result_attr = { name: "Yoda" }
      first_result = Merchant.search_by(first_params)
      nil_result = Merchant.search_by(not_result_attr)

      expect(first_result).to eq(@merchant)
      expect(nil_result).to eq(nil)
    end
  end

  context "multi finder" do
    before(:each) do
      @merchant = create(:merchant, name: "Cobbler")
    end

    it "returns an array of merchant records for case insensitive search by result" do
      first_params = { name: "CoBBLer" }
      not_result_attr = { name: "Yoda" }
      first_result = Merchant.find_all(first_params)
      nil_result = Merchant.find_all(not_result_attr)

      expect(first_result).to eq([@merchant])
      expect(nil_result).to eq([])
    end
  end

  context "#rand" do
    it "returns a random transaction record" do
      merchant_one, merchant_two = create_list(:merchant, 2)
      random_merchant = Merchant.rand

      expect(random_merchant).not_to eq(merchant_one) if random_merchant == merchant_two
    end
  end

  context "relationship endpoints" do
    before(:each) do
      @merchant = create(:merchant)
    end

    it "can return a collection of items specific to a merchant" do
      queried_items_for_merchant = Merchant.find_by(id: @merchant.id).items
      items_from_method = Merchant.items(@merchant.id)

      expect(items_from_method).to eq(queried_items_for_merchant)
    end

    it "can return a collection of invoices specific to a merchant" do
      queried_invoices_for_merchant = Merchant.find_by(id: @merchant.id).invoices
      invoices_from_method = Merchant.invoices(@merchant.id)

      expect(invoices_from_method).to eq(queried_invoices_for_merchant)
    end
  end

  context "all merchants business intelligence" do
    before(:each) do
      load_associations
    end

    it "can return top x merchants ranked by most revenue" do
      x = 1
      query = Merchant.ranked_by_most_revenue(x)

      expect(query).to eq([merchant_two])
    end

    it "can return top x merchants ranked by most items sold" do
      x = 1
      query = Merchant.ranked_by_most_items(x)

      expect(query).to eq([merchant_two])
    end

    it "can return the total revenue for date x across all merchants" do
      date = "2012-03-27 14:53:59"
      query = Merchant.total_revenue_by_date(date)

      expect(query).to eq(400)
    end
  end

  context "single merchant business intelligence" do
    before(:each) do
      load_associations
    end

    it "can return total revenue for merchant across all transactions" do
      id = 1
      query = Merchant.revenue_for_merchant(id)

      expect(query).to eq(100)
    end

    it "can return the total revenue for that merchant for a specific invoice date x" do
      id = 1
      date = "2012-03-27 14:53:59"
      query = Merchant.revenue_for_merchant_by_date(id, date)

      expect(query).to eq(200)
    end

    it "returns the customer who has conducted the most total number of successful transactions" do
      id = 2
      query = Merchant.favorite_customer_for_merchant(id)

      expect(query).to eq(customer_one)
    end

    it "returns a collection of customers which have pending (unpaid) invoices" do
      id = 1

      query = Merchant.customers_with_pending_invoices_for_merchant(id)

      expect(query).to eq([customer_two])
      expect(query.count).to eq(1)
    end
  end
end
