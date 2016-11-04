FactoryGirl.define do
  factory :lo do
    name
    description "This is the description"
    user

    transient do
      introductions_count 0
      exercises_count 0
    end

    after(:create) do |lo, evaluator|
      create_list(:introduction, evaluator.introductions_count, lo: lo)
      create_list(:exercise, evaluator.exercises_count, lo: lo)
    end
  end
end
