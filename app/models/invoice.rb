class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant

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
