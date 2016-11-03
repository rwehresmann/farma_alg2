FactoryGirl.define do
  factory :test_case do
    title "This is the title"
    content "This is the content"
    tip "This is the tip"
    input "This is the input"
    output "This is the output"
    check_program "check"
    question
  end
end
