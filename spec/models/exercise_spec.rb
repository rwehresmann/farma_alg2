require 'rails_helper'

describe Exercise, type: :model do
  context "when deleted" do
    before { create(:exercise, questions_count: 2) }

    it "deletes associated introductions" do
      expect{ Exercise.first.delete }.to change{ Question.count }
    end
  end

  describe "Validations ->" do
    let(:exercise) { build(:exercise) }

    it "is invalid with empty title" do
      exercise.title = ""
      expect(exercise).to_not be_valid
    end

    it "is invalid with empty content" do
      exercise.content = ""
      expect(exercise).to_not be_valid
    end

    describe "'available' attribute" do
      it "is false by default" do
        expect(exercise.available).to be_falsey
      end
    end
  end

  describe "Relationships ->" do
    it "belongs to learning object" do
      expect(Exercise.reflect_on_association(:learning_object).macro).to eq(:belongs_to)
    end
  end

  describe "Default scope ->" do
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

    it "orders decrescent time creation" do
      expect(Exercise.all.to_a).to eq([exercise_1, exercise_2])
    end
  end

  describe "#set_position" do
    it "set a value to 'position' attribute after create it" do
      expect(create(:exercise).position).to_not be_nil
    end
  end
end
