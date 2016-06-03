class DateSerializer < ActiveModel::Serializer
  attributes :date

  def date
    object.strftime("%FT%T.%LZ")
  end
end
