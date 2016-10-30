FactoryGirl.define do
  sequence(:email) { |i| "user_#{i}@mail.com" }

  factory :user do
    email
    name "User"
    password "foobar"

    trait :admin do
      admin true
    end
  end
end
