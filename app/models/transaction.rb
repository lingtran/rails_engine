class Transaction < ActiveRecord::Base
  belongs_to :invoice
  delegate :customer, to: :invoice

  validates :invoice_id, presence: true
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: false
  validates :result, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.search_by(params)
    if params[:result]
      find_by("lower(result) LIKE ?", params[:result].downcase)
    else
      find_by(params)
    end
  end

  def self.find_all(params)
    if params[:result]
      where("lower(result) LIKE ?", params[:result].downcase)
    else
      where(params)
    end
  end

  def self.rand
    order("RANDOM()").first
  end
end
