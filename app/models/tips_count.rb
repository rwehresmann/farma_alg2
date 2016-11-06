class TipsCount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :tries, type: Integer, default: 0

  # Q: belongs_to question, but question model doesn't have a relationship whit?
  belongs_to :question
  # Q: belongs_to user, but user model doesn't have a relationship whit?
  belongs_to :user
end
