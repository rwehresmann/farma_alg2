class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :item, type: Hash

  belongs_to :user

  def self.all_from(user_id)
    recommendations = Recommendation.where(user_id: user_id)
    result = []

    recommendations.each.inject([]) do |a, r|
      if r.item.has_key?('team_id')
        result << r if Team.find(r.item['team_id']).activated
      else
        result << r
      end
    end
    result
  end

  # Q: What is the logic here?
  def self.all_from_team(user_id, team_id)
    recommendations = Recommendation.where(user_id: user_id)
    result = []

    recommendations.each do |r|
      if r.item.has_key?('team_id')
        result << r  if Team.find(r.item['team_id']).id == team_id
      else
        result << r
      end
    end
    result
  end
end
