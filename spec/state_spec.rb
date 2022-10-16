# frozen_string_literal: true

require "./app/state"

RSpec.describe ::State do
  subject { described_class.new }

  describe "initialize" do
    it "builds an object" do
      subject
    end
  end

  describe "#location" do
    it { expect(subject.location).to be_a(::Location) }
  end

  describe "#won?" do
    before do
      subject.location_key = player_location_key
      subject.items["sword"].location_key = sword_location_key
    end

    context "when win criteria are met" do
      let(:player_location_key) { "sunlit_hill" }
      let(:sword_location_key) { "inventory" }
      it { expect(subject.won?).to eq(true) }
    end

    context "when location key is not met" do
      let(:player_location_key) { "quiet_meadow" }
      let(:sword_location_key) { "inventory" }
      it { expect(subject.won?).to eq(false) }
    end

    context "when sword key is not met" do
      let(:player_location_key) { "sunlit_hill" }
      let(:sword_location_key) { "quiet_meadow" }
      it { expect(subject.won?).to eq(false) }
    end
  end
end
