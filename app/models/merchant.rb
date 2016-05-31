class Merchant < ActiveRecord::Base

  def as_json(options)
    {
      id: id,
      name: name
    }
  end
end
