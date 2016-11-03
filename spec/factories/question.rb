FactoryGirl.define do
  factory :question do
    title "This is the title"
    content "This is the content"
    exercise

    transient do
      test_cases_count 0
      last_answers_count 0
    end

    after(:create) do |question, evaluator|
      create_list(:test_case, evaluator.test_cases_count, question: question)
      create_list(:last_answer, evaluator.last_answers_count, question: question)
    end
  end
end
