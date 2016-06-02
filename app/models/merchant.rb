class Merchant < ActiveRecord::Base
  scope :basic, -> { select(:id, :name) }
  scope :successful_transacs, -> { where(transactions: {result: "success"}) }

  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.search_by(params)
    if params[:name]
      find_by("lower(name) LIKE ?", params[:name].downcase)
    else
      find_by(params)
    end
  end

  def self.find_all(params)
    if params[:name]
      where("lower(name) LIKE ?", params[:name].downcase)
    else
      where(params)
    end
  end

  def self.rand
    order("RANDOM()")
    .first
  end

  def self.items(id)
    find_by(id: id)
    .items
  end

  def self.invoices(id)
    find_by(id: id)
    .invoices
  end

  def self.ranked_by_most_revenue(quantity)
    joins(:invoice_items)
    .group(:id)
    .order("SUM(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(quantity)
  end

  def self.ranked_by_most_items(quantity)
    successful_transacs
    .joins(invoices: [:transactions, :invoice_items])
    .group(:id)
    .order("SUM(invoice_items.quantity) DESC")
    .limit(quantity)
  end

  def self.total_revenue_by_date(date)
    Invoice.joins(:transactions).where(transactions: {result: "success"}).where(created_at: date).joins(:invoice_items).sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
