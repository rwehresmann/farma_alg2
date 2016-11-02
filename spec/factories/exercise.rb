FactoryGirl.define do
  factory :exercise do
    title "This is the title"
    content "This is the content"
    learning_object

    transient do
      questions_count 0
    end

    after(:create) do |exercise, evaluator|
      create_list(:question, evaluator.questions_count, exercise: exercise)
    end
  end
end
