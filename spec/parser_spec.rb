# frozen_string_literal: true

require "./app/parser"
require "./app/state"

RSpec.describe ::Parser do
  subject { described_class.new(command, state) }
  let(:command) { nil }
  let(:state) { State.new }

  describe "initialize" do
    it "builds an object" do
      subject
    end
  end

  describe "#derive_parts" do
    let(:result) { subject.derive_parts }

    context "when command is two words with no known synonyms" do
      let(:command) { "go east" }
      it { expect(result).to eq(%w[go east]) }
    end

    context "when command is two words with a known verb synonym" do
      let(:command) { "take sword" }
      it { expect(result).to eq(%w[get sword]) }
    end

    context "when command is one word with a one-word synonym" do
      let(:command) { "inv" }
      it { expect(result).to eq(["inventory", nil]) }
    end

    context "when command is one word with a two-word synonym" do
      let(:command) { "e" }
      it { expect(result).to eq(%w[go east]) }
    end

    context "when command is an empty string" do
      let(:command) { "" }
      it { expect(result).to eq([nil, nil]) }
    end

    context "when command is nil" do
      let(:command) { nil }
      it { expect(result).to eq([nil, nil]) }
    end
  end
end
