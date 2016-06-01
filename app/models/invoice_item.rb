class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  def self.rand
    order("RANDOM()").first
  end
end
