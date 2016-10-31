FactoryGirl.define do
  sequence(:name) { |i| "Learning Object #{i}" }

  factory :learning_object do
    name
    description "This is the description"
    user
  end
end
