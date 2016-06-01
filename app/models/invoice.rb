class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.search_by(params)
    if params[:status]
      find_by("lower(status) LIKE ?", params[:status].downcase)
    else
      find_by(params)
    end
  end

  def self.find_all(params)
    if params[:status]
      where("lower(status) LIKE ?", params[:status].downcase)
    else
      where(params)
    end
  end

  def self.rand
    order("RANDOM()").first
  end
end
