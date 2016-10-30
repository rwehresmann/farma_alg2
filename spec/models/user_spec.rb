require 'rails_helper'

describe User do
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

    describe "admin" do
      it "is false by default" do
        expect(user.admin).to be_falsey
      end
    end
  end

  describe "#generate_gravatar_hash" do
    let(:user) { create(:user) }

    it "generates gravatar hash" do
      expect(user.gravatar).to eq(Digest::MD5.hexdigest(user.email))
    end
  end
end
