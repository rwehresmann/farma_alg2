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
