class Merchant < ActiveRecord::Base

  def as_json(options)
    {
      id: id,
      name: name
    }
  end

  def self.search(params)
    where('params = ?', { name: params[:name], created_at: params[:created_at], updated_at: params[:updated_at] })
  end
end
