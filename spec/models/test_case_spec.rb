require 'rails_helper'

RSpec.describe TestCase, type: :model do
  describe "Validations ->" do
    let(:test_case) { build(:test_case) }

    it "is invalid with empty content" do
      test_case.content = ""
      expect(test_case).to_not be_valid
    end

    it "is invalid with empty timeout" do
      test_case.timeout = ""
      expect(test_case).to_not be_valid
    end

    it "is invalid with empty title" do
      test_case.title = ""
      expect(test_case).to_not be_valid
    end

    it "is valid with valid attributes" do
      expect(test_case).to be_valid
    end

    context "'timeout' attribute" do
      it "did not accept values less or equal than 0" do
        test_case.timeout = 0
        expect(test_case).to_not be_valid
      end

      it "did not accept values greater than 100" do
        test_case.timeout = 101
        expect(test_case).to_not be_valid
      end

      it "accepts value 100" do
        test_case.timeout = 100
        expect(test_case).to_not be_valid
      end
    end

    describe "default attribute values ->" do
      it "is false by default" do
        expect(test_case.has_check_program).to be_falsey
      end

      it "is true by default" do
        expect(test_case.ignore_presentation).to be_truthy
        expect(test_case.show_input_output).to be_truthy
      end
    end
  end

  describe "Relationships ->" do
    it "belongs to question" do
      expect(TestCase.reflect_on_association(:question).macro).to eq(:belongs_to)
    end
  end
end
