FactoryGirl.define do
  factory :recommendation do
    type "This is a type"
    item {{ :key => "value" }}
    user
  end
end
