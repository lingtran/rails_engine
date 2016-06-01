FactoryGirl.define do
  factory :merchant do
    sequence :name, %w(Cobbler Blacksmith).cycle do |n|
     "#{n}"
   end
    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end
end
