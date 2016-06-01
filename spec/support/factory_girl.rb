FactoryGirl.define do
  factory :merchant do
    sequence :name, %w(Cobbler Blacksmith).cycle do |n|
     "#{n}"
    end

    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end

  factory :customer do
    sequence :first_name, %w(Stella Beau).cycle do |n|
      "#{n}"
    end

    sequence :last_name, %w(River Phoenix).cycle do |n|
      "#{n}"
    end

    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end

  factory :item do
    sequence :name, %w(Shoes Sword).cycle do |n|
      "#{n}"
    end
    description "Description"
    unit_price 100
    merchant
    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end

  factory :invoice do
    customer
    merchant
    status "shipped"
    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end

  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 100
    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end

  factory :transaction do
    invoice
    sequence :credit_card_number, %w(4654405418249632 4140149827486249).cycle do |n|
      "#{n}"
    end

    credit_card_expiration_date ""

    sequence :result, %w(success failed).cycle do |n|
      "#{n}"
    end

    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end
end
