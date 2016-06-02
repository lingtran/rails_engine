class ItemSerializer < ActiveModel::Serializer
  include SerializerHelper
  
  attributes :description, :id, :merchant_id, :name
  attribute :format_unit_price, key: :unit_price
end
