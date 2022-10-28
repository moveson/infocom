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
        name: "chest",
        description: "a large oaken chest with a heavy lock",
        location_key: "tropical_forest",
        size: 999,
        capacity: 100,
        lockable: true,
        locked: true,
        openable: true,
        opened: false,
      )
    end

    let(:key_item) do
      ::Item.new(
        id: "key",
        name: "iron key",
        description: "a solid iron key",
        location_key: "twisted_trees",
        size: 3,
        can_unlock: ["chest"]
      )
    end

    let(:sword_item) do
      ::Item.new(
        id: "sword",
        name: "engraved sword",
        description: "a jewel-encrusted sword",
        text: "Sunshine makes me happy :)",
        location_key: "items.chest",
        size: 30
      )
    end

    let(:expected_result) do
      { "sword" => sword_item, "key" => key_item, "chest" => chest_item }
    end

    it "returns a hash of items indexed by id" do
      expect(result).to eq(expected_result)
    end
  end

  describe "#characters_by_id" do
    let(:result) { subject.characters_by_id }
    let(:squirrel_character) do
      ::Character.new(
        id: "squirrel",
        name: "bright-eyed squirrel",
        description: "You see a squirrel.",
        location_key: "top_of_oak_tree",
        reactions: {
          "talk" => "The squirrel chatters back at you."
        },
        trades: [
          { "accepts" => "sandwich", "gives" => "key", "description" => "Done deal."}
        ],
      )
    end

    let(:expected_result) do
      { "squirrel" => squirrel_character }
    end

    it "returns a hash of characters indexed by id" do
      expect(result).to eq(expected_result)
    end
  end

  describe "#player_location" do
    let(:result) { subject.player_location }

    it "returns the expected Location object" do
      expect(result).to be_a(::Location)
      expect(result.name).to eq("quiet meadow")
    end
  end
end
