FactoryGirl.define do
  factory :team do
    code "This is the code"
    name
    owner_id BSON::ObjectId('4db2ebee90036f010b000001')
  end
end
