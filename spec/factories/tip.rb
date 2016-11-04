FactoryGirl.define do
  factory :tip do
    content "This is the content"
    question

    trait :two_tries do
      number_of_tries 2
    end
  end
end
