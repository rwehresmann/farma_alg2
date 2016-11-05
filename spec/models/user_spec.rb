require 'rails_helper'

describe User, type: :model do
  context "when deleted" do
    before { create(:user, los_count: 2, last_answers_count: 2,
                    recommendations_count: 2) }

    it "deletes associated learning objects" do
      expect{ User.first.delete }.to change{ Lo.count }
    end

    it "deletes associated recommendations" do
      expect{ User.first.delete }.to change{ Recommendation.count }
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
  end

  describe "#generate_gravatar_hash" do
    let(:user) { create(:user) }

    it "generates gravatar hash" do
      expect(user.gravatar).to eq(Digest::MD5.hexdigest(user.email))
    end
  end
end
