require 'rails_helper'

RSpec.describe Tip, type: :model do
  describe "Validations ->" do
    let(:tip) { build(:tip) }

    it "is valid with valid attributes" do
      expect(tip).to be_valid
    end

    it "is invalid with empty content" do
      tip.content = ""
      expect(tip).to_not be_valid
    end

    it "is invalid with no try number specificated" do
      tip.number_of_tries = ""
      expect(tip).to_not be_valid
    end

    context "'number_of_tries' attribute" do
      it "did not accept a value less than 1" do
        tip.number_of_tries = 0
        expect(tip).to_not be_valid
      end

      it "did not accept a value greater than 14" do
        tip.number_of_tries = 15
        expect(tip).to_not be_valid
      end

      it "accepts value 14" do
        tip.number_of_tries = 14
        expect(tip).to be_valid
      end
    end

    context "when 'number_of_tries' is already used in the scope (question)" do
      before do
        tip.save
        @tip = tip.dup
      end

      it "is invalid" do
        expect(@tip).to_not be_valid
      end
    end

    context "when 'number_of_tries' is used out of the scope (question)" do
      let(:question) { create(:question) }

      before do
        tip.save
        @tip = tip.dup
        @tip.update_attributes(question: question)
      end

      it "is valid" do
        expect(@tip).to be_valid
      end
    end
  end

  describe "Default scope ->" do
    let!(:tip_1) { create(:tip) }
    let!(:tip_2) { create(:tip, :two_tries) }

    it "orders in decrescent number of tries" do
      expect(Tip.all.to_a).to eq([tip_2, tip_1])
    end
  end

  describe "Relationships ->" do
    it "belongs to question" do
      expect(Tip.reflect_on_association(:question).macro).to eq(:belongs_to)
    end
  end
end
