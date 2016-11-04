FactoryGirl.define do
  factory :log do
    type "This is a type"
    user_id Moped::BSON::ObjectId.new
    params { { key: "value" } }
  end
end
