require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  describe "Relationships ->" do
    it "belongs to user" do
      expect(Recommendation.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe ".all_from" do
    let(:recommendation) { create(:recommendation) }

    context "when have the team_id key" do
      let(:new_recommendation) { build(:recommendation) }

      # Associate the recommendations to the same user, and set an inactive team
      # for a recommendation item.
      before do
        new_recommendation.user = recommendation.user
        new_recommendation.save
        create(:team, :inactive)
        recommendation.item[:team_id] = Team.first.id
        recommendation.save
      end

      it "check the team 'activated' flag and ignore it if inactive" do
        expect(Recommendation.all_from(recommendation.user_id)).to eq([new_recommendation])
      end
    end

    context "whithout team_id key" do
      it "returns the recommendation in an array" do
        expect(Recommendation.all_from(recommendation.user_id)).to eq([recommendation])
      end
    end
  end
end
