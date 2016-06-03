class Merchant < ActiveRecord::Base
  scope :basic, -> { select(:id, :name) }
  scope :joins_success_transacs, -> { joins(:transactions).where(transactions: { result: "success"}) }

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
    joins(invoices: [:transactions, :invoice_items])
    .where(transactions: { result: "success" })
    .group(:id)
    .order("SUM(invoice_items.quantity) DESC")
    .limit(quantity)
  end

  def self.total_revenue_by_date(date)
    Invoice.joins(:transactions).where(transactions: {result: "success"}).where(created_at: date).joins(:invoice_items).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.revenue_for_merchant(id)
    find(id)
    .invoices
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .joins(:invoice_items)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.revenue_for_merchant_by_date(id, date)
    Invoice
    .where({merchant_id: id, created_at: date})
    .joins(:invoice_items)
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.favorite_customer_for_merchant(id)
    id = Merchant.joins_success_transacs
    .joins(:invoices)
    .where(invoices: { merchant_id: id })
    .includes(:customers)
    .group("invoices.customer_id")
    .count
    .sort { |a,b| b[1]<=>a[1] }
    .max_by { |a,b| b }
    .first

    Customer.find(id)
  end

  def self.customers_with_pending_invoices_for_merchant(id)
    Customer
    .joins(invoices: [:transactions, :merchant])
    .where(transactions: {result: "failed"})
    .where(invoices: {merchant_id: id})
    .distinct
  end
end
