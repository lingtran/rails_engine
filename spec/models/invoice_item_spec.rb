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
