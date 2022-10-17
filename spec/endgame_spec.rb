# frozen_string_literal: true

require "./app/endgame"
require "./app/state"

RSpec.describe ::Endgame do
  describe "set_state" do
    let(:state) { ::State.new }
    let(:player_location_key) { "quiet_meadow" }
    let(:sword_location_key) { "quiet_meadow" }

    before do
      state.location_key = player_location_key
      state.items["sword"].location_key = sword_location_key
    end

    context "when no win or loss criteria are met" do
      it "does not set won or lost to true" do
        described_class.set_state(state)
        expect(state.won?).to eq(false)
        expect(state.lost?).to eq(false)
      end
    end

    context "when win criteria are met" do
      let(:player_location_key) { "sunlit_hill" }
      let(:sword_location_key) { "inventory" }

      it "sets won to true" do
        described_class.set_state(state)
        expect(state.won?).to eq(true)
        expect(state.lost?).to eq(false)
      end
    end

    context "when location key is not met" do
      let(:player_location_key) { "quiet_meadow" }
      let(:sword_location_key) { "inventory" }

      it "does not set won to true" do
        described_class.set_state(state)
        expect(state.won?).to eq(false)
        expect(state.lost?).to eq(false)
      end
    end

    context "when sword key is not met" do
      let(:player_location_key) { "sunlit_hill" }
      let(:sword_location_key) { "quiet_meadow" }

      it "does not set won to true" do
        described_class.set_state(state)
        expect(state.won?).to eq(false)
        expect(state.lost?).to eq(false)
      end
    end

    context "when lost criteria are met" do
      let(:player_location_key) { "deadly_pit" }

      it "sets lost to true" do
        described_class.set_state(state)
        expect(state.won?).to eq(false)
        expect(state.lost?).to eq(true)
      end
    end
  end
end
