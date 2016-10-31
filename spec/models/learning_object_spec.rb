require 'rails_helper'

describe LearningObject do
  let(:learning_object) { build(:learning_object) }

  describe "Validations ->" do
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
  end
end
