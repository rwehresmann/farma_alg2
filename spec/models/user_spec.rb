require 'rails_helper'

describe User do
  context "when deleted" do
    before { create(:user, learning_objects_count: 2) }

    it "delete associated learning objects" do
      expect{ User.first.delete }.to change{ LearningObject.count }
    end
  end

  describe "Validations ->" do
    let(:user) { build(:user) }

    it "is invalid with empty email" do
      user.email = ""
      expect(user.valid?).to be_falsey
    end

    it "is invalid with empty name" do
      user.name = ""
      expect(user.valid?).to be_falsey
    end

    it "is invalid with empty password" do
      user.password = ""
      expect(user.valid?).to be_falsey
    end

    it "is valid with valid attributes" do
      expect(user.valid?).to be_truthy
    end

    it "is invalid with admin = nil" do
      user.admin = nil
      expect(user.valid?).to be_falsey
    end

    it "is invalid with super_admin = nil" do
      user.super_admin = nil
      expect(user.valid?).to be_falsey
    end

    describe "'admin/super_admin' attributes" do
      it "is false by default" do
        expect(user.admin).to be_falsey
        expect(user.super_admin).to be_falsey
      end
    end
  end

  describe "associations ->" do
    it "has many learning objects" do
      expect(User.reflect_on_association(:learning_objects).macro).to eq(:has_many)
    end
  end

  describe "#generate_gravatar_hash" do
    let(:user) { create(:user) }

    it "generates gravatar hash" do
      expect(user.gravatar).to eq(Digest::MD5.hexdigest(user.email))
    end
  end
end
