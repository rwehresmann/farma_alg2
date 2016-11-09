require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "Validations ->" do
    let(:tag) { build(:tag) }

    it "is valid with valid attributes" do
      expect(tag).to be_valid
    end
  end

  describe "Relationships ->" do
    it "belongs to user" do
      expect(Tag.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe ".all_tags" do
    before do
      3.times { create(:tag) }
      Tag.last.update_attributes(name: "A error")
    end

    it "returns teh tags ordered by their names" do
      expect(Tag.all_tags).to eq(Tag.order_by(name: :asc))
    end
  end
end
