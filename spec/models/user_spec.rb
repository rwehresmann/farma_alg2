require 'rails_helper'

describe User, type: :model do
  context "when deleted" do
    before { create(:user, los_count: 2, last_answers_count: 2,
                    recommendations_count: 2, tags_count: 2) }

    it "deletes associated learning objects" do
      expect{ User.first.delete }.to change{ Lo.count }
    end

    it "deletes associated recommendations" do
      expect{ User.first.delete }.to change{ Recommendation.count }
    end

    it "deletes associated tags" do
      expect{ User.first.delete }.to change{ Tag.count }
    end
  end

  describe "Validations ->" do
    let(:user) { build(:user) }

    it "is invalid with empty email" do
      user.email = ""
      expect(user).to_not be_valid
    end

    it "is invalid with empty name" do
      user.name = ""
      expect(user).to_not be_valid
    end

    it "is invalid with empty password" do
      user.password = ""
      expect(user).to_not be_valid
    end

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is invalid with admin = nil" do
      user.admin = nil
      expect(user).to_not be_valid
    end

    it "is invalid with super_admin = nil" do
      user.super_admin = nil
      expect(user).to_not be_valid
    end

    describe "'admin/super_admin' attributes" do
      it "is false by default" do
        expect(user.admin).to be_falsey
        expect(user.super_admin).to be_falsey
      end
    end
  end

  describe "Relationships ->" do
    it "has many learning objects" do
      expect(User.reflect_on_association(:los).macro).to eq(:has_many)
    end

    it "has and belongs to many teams" do
      expect(User.reflect_on_association(:teams).macro).to eq(:has_and_belongs_to_many)
    end

    it "has many last answers" do
      expect(User.reflect_on_association(:last_answers).macro).to eq(:has_many)
    end

    it "has many recommendations" do
      expect(User.reflect_on_association(:recommendations).macro).to eq(:has_many)
    end

    it "has many tags" do
      expect(User.reflect_on_association(:tags).macro).to eq(:has_many)
    end
  end

  describe "#generate_gravatar_hash" do
    let(:user) { create(:user) }

    it "generates gravatar hash" do
      expect(user.gravatar).to eq(Digest::MD5.hexdigest(user.email))
    end
  end

  describe "#add_team" do
    let(:user) { create(:user) }
    before { user.add_team(create(:team)) }

    it "adds a team to user" do
      expect(user.teams.count).to eq(1)
    end
  end

  describe "#all_teams" do
    let(:user) { create(:user) }

    # Create three teams, make the user owner of the first and a participant
    # of the last.
    before do
      3.times { create(:team) }
      Team.first.update_attributes(owner_id: user.id)
      user.add_team(Team.last)
    end

    context "when user is admin" do
      before { user.update_attributes(admin: true) }

      it "returns all teams" do
        expect(user.all_teams).to eq(Team.all.asc(:name).to_a)
      end
    end

    context "when user is not admin" do
      it "return only the teams where the user is the owner and he belongs" do
        teams = Team.where(owner_id: user.id).asc('name').to_a + user.teams
        expect(user.all_teams).to eq(teams)
      end
    end
  end
end
