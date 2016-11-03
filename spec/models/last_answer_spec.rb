require 'rails_helper'

RSpec.describe LastAnswer, type: :model do
  describe "Relationships ->" do
    let(:last_answer) { build(:last_answer) }

    it "belongs to question" do
      expect(LastAnswer.reflect_on_association(:question).macro).to eq(:belongs_to)
    end

    it "belongs to user" do
      expect(LastAnswer.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    xit "belongs to answer" do
      expect(LastAnswer.reflect_on_association(:answer).macro).to eq(:belongs_to)
    end
  end

  describe "scope" do
    let!(:exercise_1) { create(:exercise) }
    let!(:exercise_2) { create(:exercise) }

    # :set_position is called in a before_create in exercise model, so
    # it's necessary set the intended position and save the objects again
    # ('let!' is creating with the same position).
    before do
      exercise_1.position = 2
      exercise_2.position = 1
      exercise_1.save
      exercise_2.save
    end

    xit "returns the last answer by user id" do

    end
  end

end
