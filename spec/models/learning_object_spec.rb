require 'rails_helper'

describe LearningObject do
  context "when deleted" do
    before { create(:learning_object, introductions_count: 2, exercises_count: 2) }

    it "deletes associated introductions" do
      expect{ LearningObject.first.delete }.to change{ Introduction.count }
    end

    it "deletes associated exercises" do
      expect{ LearningObject.first.delete }.to change{ Exercise.count }
    end
  end

  describe "Validations ->" do
    let(:learning_object) { build(:learning_object) }

    it "is invalid with empty name" do
      learning_object.name = ""
      expect(learning_object.valid?).to be_falsey
    end

    it "is invalid with empty description" do
      learning_object.description = ""
      expect(learning_object.valid?).to be_falsey
    end

    context "when 'name' is already used" do
      before do
        learning_object.save
        @learning_object = learning_object.dup
      end

      it "is invalid" do
        expect(@learning_object).to_not be_valid
      end
    end

    describe "'available' attribute" do
      it "is false by default" do
        expect(learning_object.available).to be_falsey
      end
    end
  end

  describe "associations ->" do
    it "belongs to user" do
      expect(LearningObject.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "has many introductions" do
      expect(LearningObject.reflect_on_association(:introductions).macro).to eq(:has_many)
    end

    it "has and belogns to many teams" do
      expect(LearningObject.reflect_on_association(:teams).macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe "#pages_count" do
    let!(:learning_object) { create(:learning_object, introductions_count: 1,
                            exercises_count: 2) }

    # available is false by default.
    before do
      Exercise.update_all(available: true)
      Introduction.update_all(available: true)
    end

    it "returns 3" do
      expect(learning_object.pages_count).to eq(3)
    end
  end
end
