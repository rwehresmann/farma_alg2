class LearningObject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :available, type: Boolean, default: false

  belongs_to :user
  has_many :introductions, dependent: :delete
  has_many :exercises, dependent: :delete

  validates_presence_of :name, :description
  validates :name, uniqueness: true
  #validates :available, :inclusion => {:in => [true, false]}
end
