class Team
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :name, type: String
  # Moped::BSON::ObjectId stores the id directly.
  field :owner_id, type: Moped::BSON::ObjectId
  # For some reason, for the word 'active' mongoid doesn't set a default value.
  # So it was changed to activated.
  field :activated, type: Boolean, default: true

  has_and_belongs_to_many :los
  has_and_belongs_to_many :users

  validates_presence_of :name, :code
  validates_uniqueness_of :name

  # Return scope not the records
  def self.search(search = "")
    return all.desc(:created_at) if search.empty?
    any_of(:name => search).desc(:created_at)
  end

  def add_user(user)
    users << user
  end
end
