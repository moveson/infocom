# frozen_string_literal: true

require "./lib/core_ext/string"

RSpec.describe String do
  describe "#articleize" do
    let(:result) { string.articleize }

    context "for a single-word string that needs 'a'" do
      let(:string) { "sword" }
      it { expect(result).to eq("a sword") }
    end

    context "for a single-word string that needs 'an'" do
      let(:string) { "eggshell" }
      it { expect(result).to eq("an eggshell") }
    end

    context "for a multiple-word string that needs 'a'" do
      let(:string) { "large balloon" }
      it { expect(result).to eq("a large balloon") }
    end

    context "for a multiple-word string that needs 'an'" do
      let(:string) { "oaken chest" }
      it { expect(result).to eq("an oaken chest") }
    end
  end
end
