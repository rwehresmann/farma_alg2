require 'rails_helper'

describe Lo do
  context "when deleted" do
    before { create(:lo, introductions_count: 2, exercises_count: 2) }

    it "deletes associated introductions" do
      expect{ Lo.first.delete }.to change{ Introduction.count }
    end

    it "deletes associated exercises" do
      expect{ Lo.first.delete }.to change{ Exercise.count }
    end
  end

  describe "Validations ->" do
    let(:lo) { build(:lo) }

    it "is invalid with empty name" do
      lo.name = ""
      expect(lo.valid?).to be_falsey
    end

    it "is invalid with empty description" do
      lo.description = ""
      expect(lo.valid?).to be_falsey
    end

    context "when 'name' is already used" do
      before do
        lo.save
        @lo = lo.dup
      end

      it "is invalid" do
        expect(@lo).to_not be_valid
      end
    end

    describe "'available' attribute" do
      it "is false by default" do
        expect(lo.available).to be_falsey
      end
    end
  end

  describe "associations ->" do
    it "belongs to user" do
      expect(Lo.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "has many introductions" do
      expect(Lo.reflect_on_association(:introductions).macro).to eq(:has_many)
    end

    it "has and belogns to many teams" do
      expect(Lo.reflect_on_association(:teams).macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe "#pages_count" do
    let!(:lo) { create(:lo, introductions_count: 1,
                            exercises_count: 2) }

    # available is false by default.
    before do
      Exercise.update_all(available: true)
      Introduction.update_all(available: true)
    end

    it "returns 3" do
      expect(lo.pages_count).to eq(3)
    end
  end
end
