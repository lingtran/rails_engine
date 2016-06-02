class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true


  def self.search_by(params)
    if params[:unit_price]
      unit_price = (params[:unit_price].to_f * 100).round
      find_by(unit_price: unit_price)
    else
      find_by(params)
    end
  end

  def self.find_all(params)
    if params[:unit_price]
      unit_price = (params[:unit_price].to_f * 100).round
      where(unit_price: unit_price)
    else
      where(params)
    end
  end

  def self.rand
    order("RANDOM()").first
  end

  def self.has_invoice(id)
    find(id).invoice
  end

  def self.has_item(id)
    find(id).item
  end

  # total
    # p = (unit_price.to_f)/100
    # total = p * quantity
end
