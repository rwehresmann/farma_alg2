class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description
  field :type, type: Integer
  field :primary, type: Boolean, default: false

  belongs_to :user
  # has_and_belongs_to_many :answers

  # Return all tags
  def self.all_tags
    Tag.all.asc(:name)
  end
end
