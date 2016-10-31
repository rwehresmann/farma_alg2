class LearningObject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :available, type: Boolean, default: false

  validates_presence_of :name, :description
  validates :name, uniqueness: true
  #validates :available, :inclusion => {:in => [true, false]}

  belongs_to :user
end
