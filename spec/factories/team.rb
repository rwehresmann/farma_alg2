FactoryGirl.define do
  factory :team do
    code "This is the code"
    name
    owner_id BSON::ObjectId.new

    trait :inactive do
      activated false
    end
  end
end
