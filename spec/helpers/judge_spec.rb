require 'rails_helper'
require 'utils/judge'

describe Judge do
  describe ".save_source_code" do
    let(:filename) { "/tmp/id-response.lang" }
    let(:source_code) { "program Hello; begin writeln ('Hello, world.') end." }
    before { Judge.save_source_code(filename, source_code) }

    it "saves a file with the source code" do
      expect(File.exist?(filename)).to be_truthy
      expect(File.read(filename)).to eq(source_code)
    end
  end

  describe ".compile" do
    context "when source code is wrong" do
      let(:source_code_wrong) { "program Hello; begin weln ('Hello, world.') end." }
      subject { Judge.compile("pas", source_code_wrong, 1) }

      it "returns an array where the first elements is 1" do
        expect(subject.class).to eq(Array)
        expect(subject.first).to eq(1)
      end
    end

    context "when source code is wright" do
      let(:source_code_wrigth) { "program Hello; begin writeln ('Hello, world.') end." }
      subject { Judge.compile("pas", source_code_wrigth, 1) }

      it "returns an array where the first elements is 0" do
        expect(subject.class).to eq(Array)
        expect(subject.first).to eq(0)
      end
    end
  end
end
