require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:invoice_id) }
    it { is_expected.to validate_presence_of(:credit_card_number) }
    it { is_expected.to validate_presence_of(:credit_card_expiration_date) }
    it { is_expected.to validate_presence_of(:result) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  context "associations" do
    it { should belong_to(:invoice) }
    it { should belong_to(:customer).class_name("Invoice") }
  end
end
