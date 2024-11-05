# frozen_string_literal: true

require "./app/endgame"
require "./app/models/item"
require "./app/models/state"
require "active_support/core_ext/string"

RSpec.describe ::Endgame do
  describe ".condition" do
    let(:result) { described_class.condition(state) }
    let(:state) { ::State.new }
    let(:player_location_id) { "quiet_meadow" }
    let(:sword_location_key) { "quiet_meadow" }
    let(:player_health) { 10 }

    before do
      state.adventure = "primis"
      state.player_location_id = player_location_id
      state.player.health = player_health
      state.items = [::Item.new(id: "sword", location_key: sword_location_key)]
    end

    context "when no win or loss criteria are met" do
      it { expect(result).to eq("in_progress") }
    end

    context "when win criteria are met" do
      let(:player_location_id) { "sunlit_hill" }
      let(:sword_location_key) { "items.slab" }

      it { expect(result).to eq("won") }
    end

    context "when location key is not met" do
      let(:player_location_id) { "quiet_meadow" }
      let(:sword_location_key) { "inventory" }

      it { expect(result).to eq("in_progress") }
    end

    context "when sword key is not met" do
      let(:player_location_id) { "sunlit_hill" }
      let(:sword_location_key) { "quiet_meadow" }

      it { expect(result).to eq("in_progress") }
    end

    context "when health falls to 0" do
      let(:player_health) { 0 }

      it { expect(result).to eq("lost") }
    end
  end
end
