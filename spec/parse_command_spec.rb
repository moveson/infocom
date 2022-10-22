# frozen_string_literal: true

require "./app/parse_command"
require "./app/models/state"

RSpec.describe ::ParseCommand do
  let(:command) { nil }
  let(:state) { ::State.new }

  describe ".perform" do
    let(:result) { described_class.perform(command, state) }

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

    context "when command is a direction without a verb" do
      let(:command) { "east" }
      it { expect(result).to eq(::Grammar.new(verb: "go", noun: "east")) }
    end

    context "when command is a direction synonym without a verb" do
      let(:command) { "e" }
      it { expect(result).to eq(::Grammar.new(verb: "go", noun: "east")) }
    end

    context "when the command contains one or more articles" do
      let(:command) { "get the sword" }
      it { expect(result).to eq(::Grammar.new(verb: "get", noun: "sword")) }
    end

    context "when the command is four words" do
      let(:command) { "put sword into chest" }
      it { expect(result).to eq(::Grammar.new(verb: "put", noun: "sword", preposition: "into", object: "chest")) }
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
