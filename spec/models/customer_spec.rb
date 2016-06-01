require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  context "single finder" do
    before(:each) do
      @customer = create(:customer, first_name: "Stella")
    end

    it "returns a single customer record for case insensitive search by result" do
      first_params = { first_name: "SteLLa" }
      not_result_attr = { first_name: "Ming" }
      first_result = Customer.search_by(first_params)
      nil_result = Customer.search_by(not_result_attr)

      expect(first_result).to eq(@customer)
      expect(nil_result).to eq(nil)
    end
  end

  context "multi finder" do
    before(:each) do
      @customer = create(:customer, first_name: "Stella")
    end

    it "returns an array of customer records for case insensitive search by result" do
      first_params = { first_name: "SteLLa" }
      not_result_attr = { first_name: "Ming" }
      first_result = Customer.find_all(first_params)
      nil_result = Customer.find_all(not_result_attr)

      expect(first_result).to eq([@customer])
      expect(nil_result).to eq([])
    end
  end

  context "#rand" do
    it "returns a random transaction record" do
      customer_one, customer_two = create_list(:customer, 2)
      random_customer = Customer.rand

      expect(random_customer).not_to eq(customer_one) if random_customer == customer_two
    end
  end

end
