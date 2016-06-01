class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.rand
    order("RANDOM()").first
  end

  def self.has_invoice(id)
    find(id).invoice
  end

  def self.has_item(id)
    find(id).item
  end
end
