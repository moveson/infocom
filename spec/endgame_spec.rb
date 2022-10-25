# frozen_string_literal: true

require "./app/endgame"
require "./app/models/item"
require "./app/models/state"

RSpec.describe ::Endgame do
  describe ".condition" do
    let(:result) { described_class.condition(state) }
    let(:state) { ::State.new }
    let(:player_location_key) { "quiet_meadow" }
    let(:sword_location_key) { "quiet_meadow" }

    before do
      state.player_location_key = player_location_key
      state.items = [::Item.new(id: "sword", location_key: sword_location_key)]
    end

    context "when no win or loss criteria are met" do
      it { expect(result).to eq("in_progress") }
    end

    context "when win criteria are met" do
      let(:player_location_key) { "sunlit_hill" }
      let(:sword_location_key) { "items.slab" }

      it { expect(result).to eq("won") }
    end

    context "when location key is not met" do
      let(:player_location_key) { "quiet_meadow" }
      let(:sword_location_key) { "inventory" }

      it { expect(result).to eq("in_progress") }
    end

    context "when sword key is not met" do
      let(:player_location_key) { "sunlit_hill" }
      let(:sword_location_key) { "quiet_meadow" }

      it { expect(result).to eq("in_progress") }
    end

    context "when lost criteria are met" do
      let(:player_location_key) { "deadly_pit" }

      it { expect(result).to eq("lost") }
    end
  end
end
