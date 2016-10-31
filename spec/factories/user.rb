FactoryGirl.define do
  sequence(:email) { |i| "user_#{i}@mail.com" }

  factory :user do
    email
    name "User"
    password "foobar"

    trait :admin do
      admin true
    end

    # Create a local variable with the number of learning objects to create.
    transient do
      learning_objects_count 2
    end

    # Through evaluator we access the transient counter, and say that
    # we would like to create learning objects (create_list 1st argument) that
    # belongs to the user created above (create_list 3th argument).
    after(:create) do |user, evaluator|
      create_list(:learning_object, evaluator.learning_objects_count, user: user)
    end
  end
end
