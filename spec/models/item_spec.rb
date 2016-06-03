require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:merchant_id) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
  end

  context "single finder" do
    before(:each) do
      @item = create(:item, name: "Sword")
    end

    it "returns a single item record for case insensitive search by result" do
      first_params = { name: "swORd" }
      not_result_attr = { name: "butter knife" }
      first_result = Item.search_by(first_params)
      nil_result = Item.search_by(not_result_attr)

      expect(first_result).to eq(@item)
      expect(nil_result).to eq(nil)
    end

    it "returns a single item record for other searches" do
      params = { unit_price: "1.00" }
      not_number = { unit_price: "2.00"}
      result = Item.search_by(params)
      nil_result = Item.search_by(not_number)

      expect(result).to eq(@item)
      expect(nil_result).to eq(nil)
    end
  end

  context "multi finder" do
    before(:each) do
      @item = create(:item, name: "Sword")
    end

    it "returns an array of item records for case insensitive search by result" do
      first_params = { name: "swORd" }
      not_result_attr = { name: "butter knife" }
      first_result = Item.find_all(first_params)
      nil_result = Item.find_all(not_result_attr)

      expect(first_result).to eq([@item])
      expect(nil_result).to eq([])
    end

    it "returns an array of item records for other searches" do
      params = { unit_price: "1.00" }
      not_number = { unit_price: "2.00" }
      result = Item.find_all(params)
      nil_result = Item.find_all(not_number)

      expect(result).to eq([@item])
      expect(nil_result).to eq([])
    end
  end

  context "#rand" do
    it "returns a random item record" do
      item_one, item_two = create_list(:item, 2)
      random_item = Item.rand

      expect(random_item).not_to eq(item_one) if random_item == item_two
    end
  end

  context "business intelligence endpoints" do
    before(:each) do
      load_associations
    end

    it "returns the top x items ranked by total revenue generated" do
      x = 2
      query = Item.ranked_by_most_revenue(x)

      expect(query.length).to eq(2)
      expect(query).to eq([item_five, item_two])
    end

    it "returns the top x item instances ranked by total number sold" do
      x = 2
      query = Item.ranked_by_most_items(x)

      expect(query.length).to eq(2)
      expect(query).to eq([item_five, item_two])
    end

    it "returns the date with the most sales for the given item using the invoice date" do
      item_id = 2
      query = Item.best_day(item_id)
      best_day = query.strftime("%FT%T.%LZ")

      expect(best_day).to eq("2012-03-27T14:53:59.000Z")
    end
  end
end
