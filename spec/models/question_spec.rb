require 'rails_helper'

describe Question, type: :model do
  describe "Validations ->" do
    let(:question) { build(:question) }

    it "is invalid with empty title" do
      question.title = ""
      expect(question).to_not be_valid
    end

    it "is invalid with empty content" do
      question.content = ""
      expect(question).to_not be_valid
    end
  end

  describe "Relationships ->" do
    it "belongs to exercise" do
      expect(Question.reflect_on_association(:exercise).macro).to eq(:belongs_to)
    end
  end

  describe "Default scope ->" do
    let!(:question_1) { create(:question) }
    let!(:question_2) { create(:question) }

    # :set_position is called in a before_create in exercise model, so
    # it's necessary set the intended position and save the objects again
    # ('let!' is creating with the same position).
    before do
      question_1.position = 2
      question_2.position = 1
      question_1.save
      question_2.save
    end

    it "orders by decrescent time creation" do
      expect(Question.all.to_a).to eq([question_1, question_2])
    end
  end

  describe "#set_position" do
    it "set a value to 'position' attribute after create it" do
      expect(create(:question).position).to_not be_nil
    end
  end
end
