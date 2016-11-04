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
  field :teacher, :type => Boolean, default: false
  field :super_admin, :type => Boolean, default: false
  field :guest, :type => Boolean, default: false
  field :show_help, :type => Boolean, default: true

  has_many :los, dependent: :delete
  has_many :last_answers, dependent: :delete
  has_many :recommendations, dependent: :delete
  has_and_belongs_to_many :teams

  validates_presence_of :name
  validate :cannot_be_nil

  index({ email: 1 }, { unique: true, background: true })

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
