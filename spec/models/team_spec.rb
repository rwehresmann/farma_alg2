require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "Validations ->" do
    let(:team) { build(:team) }

    it "is invalid with empty code" do
      team.code = ""
      expect(team).to_not be_valid
    end

    it "is invalid with empty name" do
      team.name = ""
      expect(team).to_not be_valid
    end

    describe "'activated' attribute" do
      it "is true by default" do
        expect(team.activated).to be_truthy
      end
    end

    context "when 'name' is already used" do
      before do
        team.save
        @team = team.dup
      end

      it "is invalid" do
        expect(@team).to_not be_valid
      end
    end
  end

  describe "Relationships ->" do
    it "has and belongs to many exercises" do
      expect(Team.reflect_on_association(:los).macro).to eq(:has_and_belongs_to_many)
    end

    it "has and belongs to many users" do
      expect(Team.reflect_on_association(:users).macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe ".search" do
    let!(:team_1) { create(:team) }
    let!(:team_2) { create(:team) }

    # 'let!' create teams at the same time, so it is necessary update the time
    # of one of them.
    before do
      team_2.created_at = 1.day.from_now
      team_2.save
    end

    context "when search parameter is passed" do
      it "should return the match" do
        expect(Team.search(team_2.name).to_a).to eq([team_2])
      end
    end

    context "when search parameter is not passed" do
      it "returns the teams in date creation decrescent order" do
        expect(Team.search.to_a).to eq([team_2, team_1])
      end
    end
  end
end
