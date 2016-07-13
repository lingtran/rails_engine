class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.search_by(params)
    if params[:name]
      find_by("lower(name) LIKE ?", params[:name].downcase)
    elsif params[:description]
      find_by("lower(description) LIKE ?", params[:description].downcase)
    elsif params[:unit_price]
      unit_price = (params[:unit_price].to_f * 100).round
      find_by(unit_price: unit_price)
    else
      find_by(params)
    end
  end

  def self.find_all(params)
    if params[:name]
      where("lower(name) LIKE ?", params[:name].downcase)
    elsif params[:descriptions]
      where("lower(description) LIKE ?", params[:description].downcase)
    elsif params[:unit_price]
      unit_price = (params[:unit_price].to_f * 100).round
      where(unit_price: unit_price)
    else
      where(params)
    end
  end

  def self.rand
    order("RANDOM()").first
  end

  def self.ranked_by_most_revenue(quantity)
    joins(:invoice_items)
    .group(:id)
    .order("SUM(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(quantity)
  end

  def self.ranked_by_most_items(quantity)
    joins(:invoice_items)
    .group(:id)
    .order("SUM(invoice_items.quantity) DESC")
    .limit(quantity)
  end

  def self.best_day(id)
    Invoice
    .joins(:invoice_items)
    .where(invoice_items: {item_id: id})
    .group(:id)
    .order("SUM(invoice_items.quantity) DESC")
    .limit(1)
    .first
    .created_at
  end
end
