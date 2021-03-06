class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  #embedded_in :answer, :polymorphic => true, :inverse_of => :comments
  belongs_to :answer

  field :text, type: String
  field :user_id, type: Moped::BSON::ObjectId
  field :team_id, type: Moped::BSON::ObjectId
  field :question_id, type: Moped::BSON::ObjectId
  field :target_user_id, type: Moped::BSON::ObjectId

  default_scope -> { order_by([:created_at, :asc]) }

  after_create :send_mail

  def user
    @user ||= User.find(self.user_id)
  end

  def can_destroy?(user)
    self.created_at >= 15.minutes.ago && self.user_id == user.id
  end

  def send_mail
    if self.user_id == self.answer.user_id
      user_id = Team.find(self.answer.team_id).owner_id
    else
      user_id = self.answer.user_id
    end

    MessageMailer.comment_received(self,User.find(user_id)).deliver
  end
end
