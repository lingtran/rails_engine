require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:item_id) }
    it { is_expected.to validate_presence_of(:invoice_id) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  context"#rand" do
    it "returns a random invoice item record" do
      invoice_item_one, invoice_item_two = create_list(:invoice_item, 2)
      random_invoice_item = InvoiceItem.rand

      expect(random_invoice_item).not_to eq(invoice_item_one) if random_invoice_item == invoice_item_two
    end
  end

  context "single finder" do
    before(:each) do
      item = create(:item)
      invoice = create(:invoice)
      @invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    end

    it "returns a single invoice item record for unit price" do
      params = { unit_price: "1.00" }
      not_number = { unit_price: "2.00"}
      result = InvoiceItem.search_by(params)
      nil_result = InvoiceItem.search_by(not_number)

      expect(result).to eq(@invoice_item)
      expect(nil_result).to eq(nil)
    end
  end

  context "multi finder" do
    before(:each) do
      item = create(:item)
      invoice = create(:invoice)
      @invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    end

    it "returns a collection of invoice item records for unit price" do
      params = { unit_price: "1.00" }
      not_number = { unit_price: "2.00"}
      result = InvoiceItem.find_all(params)
      nil_result = InvoiceItem.find_all(not_number)

      expect(result).to eq([@invoice_item])
      expect(nil_result).to eq([])
    end
  end

  context "relationship endpoints" do
    before(:each) do
      @invoice_item = create(:invoice_item)
    end

    it "returns the associated invoice" do
      queried_invoice_for_invoice_item = InvoiceItem.find(@invoice_item.id).invoice
      invoice_method = InvoiceItem.has_invoice(@invoice_item.id)

      expect(invoice_method).to eq(queried_invoice_for_invoice_item)
    end

    it "returns the associated item" do
      queried_item_for_invoice_item = InvoiceItem.find(@invoice_item.id).item
      item_method = InvoiceItem.has_item(@invoice_item.id)

      expect(item_method).to eq(queried_item_for_invoice_item)
    end
  end
end
