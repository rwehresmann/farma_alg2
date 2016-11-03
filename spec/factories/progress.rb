FactoryGirl.define do
  factory :progress do
    team_id Moped::BSON::ObjectId.new
    question_id Moped::BSON::ObjectId.new
    user_id Moped::BSON::ObjectId.new
  end
end
