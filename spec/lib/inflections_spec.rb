# frozen_string_literal: true

require "./lib/inflections"

RSpec.describe Inflections do
  describe ".indefinite_article" do
    let(:result) { described_class.indefinite_article(text) }

    context "for a single word that requires 'a'" do
      let(:text) { "sword" }
      it { expect(result).to eq("a") }
    end

    context "for a single word that requires 'an'" do
      let(:text) { "egg" }
      it { expect(result).to eq("an") }
    end

    context "for multiple words that require 'a'" do
      let(:text) { "large chest" }
      it { expect(result).to eq("a") }
    end

    context "for multiple words that require 'an'" do
      let(:text) { "oaken chest" }
      it { expect(result).to eq("an") }
    end

    context "for words that buck the first-letter trend" do
      let(:text) { "honest" }
      it { expect(result).to eq("an") }
    end

    context "for hyphenated words" do
      let(:text) { "honest-to-goodness" }
      it { expect(result).to eq("an") }
    end
  end
end
