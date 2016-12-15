class User
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save :generate_gravatar_hash

  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  # field :reset_password_token,   type: String
  # field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :name, :type => String
  field :gravatar
  field :admin, :type => Boolean, default: false
  field :prof, :type => Boolean, default: false
  field :super_admin, :type => Boolean, default: false
  field :guest, :type => Boolean, default: false
  field :show_help, :type => Boolean, default: true

  has_many :los, dependent: :delete
  has_many :answers, dependent: :delete
  has_many :retroaction_answers, dependent: :delete
  has_many :last_answers, dependent: :delete
  has_many :tags, dependent: :delete
  has_many :messages, dependent: :delete
  has_and_belongs_to_many :teams
  has_many :replies, dependent: :delete
  has_many :recommendations, dependent: :delete

  validates_presence_of :name
  validate :cannot_be_nil

  index({ email: 1 }, { unique: true, background: true })

  def questions_without_tries
    questions = []

    self.teams.each do |t|
      t.los.each do |lo|
        lo.exercises.each do |ex|
          ex.questions.each do |q|
            if self.progress_question(t.id,q.id) == 0.0
              questions << [t,q]
            end
          end
        end
      end
    end
    questions
  end

  def last_try
    Answer.where(:user_id => self.id).desc(:created_at).first
  end

  def all_los
    if self.admin?
      Lo.all.asc(:name)
    else
      los = Array.new
      for team in self.all_teams do
        lo_ids = Answer.where(team_id:team.id).desc("lo_id").distinct("lo_id")
        if lo_ids.empty?
          los = los + team.los
        else
          los = los + (Lo.find(lo_ids) | team.los)
        end
      end

      if self.prof?
        los += self.los
      end

      los.uniq{|x| x.id}.sort_by{:name}
    end
  end

  def all_tags
    Tag.all.asc(:name)
  end

  def all_questions
    if self.admin?
      Question.all.asc(:title)
    else
      answered_questions = Answer.where(user_id:self.id).desc("question_id").distinct("question_id")
      questions = []
      unless answered_questions.empty?
        questions = Question.find(answered_questions)
      end

      question_ids = []
      for lo in self.all_los
        for ex in lo.exercises
          question_ids = question_ids + ex.question_ids
        end
      end

      questions = questions + Question.find(question_ids)
      questions.uniq{|x| x.id}.sort_by{|x| x.title}
    end
  end

  def last_messages_to_me(n)
    @messages = Message.any_of({:target_user_ids => self.id}, {:user_ids => self.id.to_s}).desc(:updated_at).desc(:updated_at).to_a + self.messages.keep_if {|x| x['new_flag_user_id'] }
    @messages.sort { |x,y| y.updated_at <=> x.updated_at}
  end

  def number_of_new_messages
    Message.any_of(:new_flag_user_ids => self.id).count + self.messages.keep_if {|x| x['new_flag_user_id'] }.count
  end

  def student?
    if self.prof? && (not self.admin?)
      return false
    end
    return true
  end

  # Return teams according user privilege level.
  def all_teams
    if admin?
      Team.all.asc(:name).to_a
    else
      # Q: shoul i realy put teams.asc('name')? That isn't right, according
      # other methods like 'all_teams_id'.
      Team.where(owner_id: id).asc('name').to_a + teams.asc('name')
    end
  end

  # Return teams id according user privilege level.
  def all_teams_id
    if admin?
      Team.all.pluck(:id)
    else
      Team.where(owner_id: id).pluck(:id)
    end
  end

  # Return users according privilege level.
  def all_students
    if admin?
      User.all.asc(:name).to_a
    else
      user_teams = Team.where(owner_id: id).asc('name').to_a
      users = user_teams.each.inject([self]) { |array, team| array = array + team.users }
      users.uniq.sort_by(&:name)
    end
  end

  # Add the user to a team.
  def add_team(team)
    teams << team
  end

  private

     # Custom validation for nil value
     def cannot_be_nil
       errors.add(:admin, "cannot be nil") if admin.nil?
       errors.add(:super_admin, "cannot be nil") if super_admin.nil?
     end

    # Gravatar URLs are based on an MD5 hash
    def generate_gravatar_hash
      self.gravatar = Digest::MD5.hexdigest(self.email)
    end
end
