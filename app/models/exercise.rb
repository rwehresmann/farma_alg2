class Exercise
  include Mongoid::Document
  include Mongoid::Timestamps

  before_create :set_position

  field :title, type: String
  field :content, type: String
  field :available, type: Boolean, default: false
  field :position, type: Integer

  belongs_to :lo
  has_many :questions, dependent: :delete

  validates_presence_of :title, :content
  #validates :available, :inclusion => {:in => [true, false]}

  default_scope -> { desc(:position) }

  private

    def set_position
      self.position = Time.now.to_i
    end
end
