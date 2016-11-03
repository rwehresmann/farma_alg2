FactoryGirl.define do
  sequence(:name) { |i| "Name #{i}" }
  sequence(:email) { |i| "user_#{i}@mail.com" }
end
