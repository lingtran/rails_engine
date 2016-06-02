class InvoiceItemSerializer < ActiveModel::Serializer
  include SerializerHelper
  attributes :id, :invoice_id, :item_id, :quantity
  attribute :format_unit_price, key: :unit_price
end
