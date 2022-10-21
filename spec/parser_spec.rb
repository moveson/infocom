# frozen_string_literal: true

require "./app/parser"
require "./app/models/state"

RSpec.describe ::Parser do
  let(:command) { nil }
  let(:state) { ::State.new }

  describe "#derive_parts" do
    let(:result) { described_class.derive_parts(command, state) }

    context "when command is two words with no known synonyms" do
      let(:command) { "go east" }
      it { expect(result).to eq(::Grammar.new(verb: "go", noun: "east")) }
    end

    context "when command is two words with a known verb synonym" do
      let(:command) { "take sword" }
      it { expect(result).to eq(::Grammar.new(verb: "get", noun: "sword")) }
    end

    context "when command is one word with a one-word synonym" do
      let(:command) { "inv" }
      it { expect(result).to eq(::Grammar.new(verb: "inventory")) }
    end

    context "when command is one word with a two-word synonym" do
      let(:command) { "e" }
      it { expect(result).to eq(::Grammar.new(verb: "go", noun: "east")) }
    end

    context "when the command contains one or more articles" do
      let(:command) { "get the sword" }
      it { expect(result).to eq(::Grammar.new(verb: "get", noun: "sword")) }
    end

    context "when command is an empty string" do
      let(:command) { "" }
      it { expect(result).to eq(::Grammar.new) }
    end

    context "when command is nil" do
      let(:command) { nil }
      it { expect(result).to eq(::Grammar.new) }
    end
  end
end
