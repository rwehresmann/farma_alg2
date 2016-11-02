require 'rails_helper'

describe Introduction, type: :model do
    describe "Validations ->" do
      let(:introduction) { build(:introduction) }

      it "is invalid with empty title" do
        introduction.title = ""
        expect(introduction).to_not be_valid
      end

      it "is invalid with empty content" do
        introduction.content = ""
        expect(introduction).to_not be_valid
      end

      describe "'available' attribute" do
        it "is false by default" do
          expect(introduction.available).to be_falsey
        end
      end
    end

    describe "Relationships ->" do
      it "belongs to learning object" do
        expect(Introduction.reflect_on_association(:learning_object).macro).to eq(:belongs_to)
      end
    end

    describe "Default scope ->" do
      let!(:introduction_1) { create(:introduction) }
      let!(:introduction_2) { create(:introduction) }

      # :set_position is called in a before_create in introduction model, so
      # it's necessary set the intended position and save the objects again
      # ('let!' is creating with the same position).
      before do
        introduction_1.position = 2
        introduction_2.position = 1
        introduction_1.save
        introduction_2.save
      end

      it "orders decrescent time creation" do
        expect(Introduction.all.to_a).to eq([introduction_1, introduction_2])
      end
    end

    describe "#set_position" do
      it "set a value to 'position' attribute after create it" do
        expect(create(:introduction).position).to_not be_nil
      end
    end
end
