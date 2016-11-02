FactoryGirl.define do
  sequence(:name) { |i| "Learning Object #{i}" }

  factory :learning_object do
    name
    description "This is the description"
    user

    transient do
      introductions_count 0
      exercises_count 0
    end

    after(:create) do |learning_object, evaluator|
      create_list(:introduction, evaluator.introductions_count, learning_object: learning_object)
      create_list(:exercise, evaluator.exercises_count, learning_object: learning_object)
    end
  end
end
