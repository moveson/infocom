# frozen_string_literal: true

require "./app/persist"
require "./app/models/state"

RSpec.describe ::State do
  subject { described_class.new }
  let(:test_file_path) { "./spec/fixtures/files/saved_game_test_1.yml" }

  before { ::Persist.restore_using_file_path!(subject, test_file_path) }

  describe "#items_by_id" do
    let(:result) { subject.items_by_id }
    let(:chest_item) do
      ::Item.new(
        id: "chest",
        name: "Chest",
        description: "a large oaken chest with a heavy lock",
        location_key: "tropical_forest",
        size: 999,
        capacity: 100,
        locked: true,
        opened: false
      )
    end

    let(:sword_item) do
        ::Item.new(
          id: "sword",
          name: "Sword",
          description: "a jewel-encrusted sword",
          text: "Sunshine makes me happy :)",
          location_key: "items.chest",
          size: 30
        )
    end

    it "returns a hash of items indexed by id" do
      expect(result).to eq({ "sword" => sword_item, "chest" => chest_item })
    end
  end

  describe "#player_location" do
    let(:result) { subject.player_location }

    it "returns the expected Location object" do
      expect(result).to be_a(::Location)
      expect(result.name).to eq("Quiet Meadow")
    end
  end
end
