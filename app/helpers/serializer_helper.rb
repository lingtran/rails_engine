module SerializerHelper
  def format_unit_price
    ((object.unit_price.to_f)/100).to_s
    # integer = object.unit_price
    # sprintf("%#g", integer).chop
  end
end
