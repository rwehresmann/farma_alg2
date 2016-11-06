require 'rails_helper'

RSpec.describe TipsCount, type: :model do
  describe "Validations ->" do
    let(:tips_count) { build(:tips_count) }

    it "is valid with valid attributes" do
      expect(tips_count).to be_valid
    end
  end

  describe "Relationships ->" do
    it "belongs to question" do
      expect(TipsCount.reflect_on_association(:question).macro).to eq(:belongs_to)
    end

    it "belongs to user" do
      expect(TipsCount.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end
