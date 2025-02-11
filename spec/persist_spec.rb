# frozen_string_literal: true

require "./app/persist"
require "./app/models/state"

RSpec.describe ::Persist do
  before { stub_const("#{described_class}::SAVED_FILE_DIRECTORY", "./spec/fixtures/files") }

  describe ".restore_using_filename!" do
    let(:result) { described_class.restore_using_filename!(state, filename) }
    let(:state) { ::State.new }
    let(:filename) { "saved_game_test_1" }
    let(:expected_locations) { [meadow_location, hill_location] }
    let(:expected_items) { [sword_item, key_item, chest_item] }
    let(:expected_characters) { [squirrel_character] }

    let(:meadow_location) do
      ::Location.new(
        "id" => "quiet_meadow",
        "name" => "quiet meadow",
        "description" => {
          "general" => "You find yourself in a quiet meadow.",
        },
        "described" => false,
        "movements" => {
          "east" => { "location_id" => "sunlit_hill" },
          "west" => { "location_id" => "twisted_trees" },
        },
      )
    end

    let(:hill_location) do
      ::Location.new(
        "id" => "sunlit_hill",
        "name" => "sunlit hill",
        "description" => {
          "general" => "A sunlit hill.",
        },
        "described" => true,
        "movements" => {
          "west" => { "location_id" => "quiet_meadow" },
        },
      )
    end

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
        size: 30,
      )
    end

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

    context "when the file exists" do
      it "returns true" do
        expect(result).to eq(true)
      end

      it "modifies state attributes as expected" do
        result
        expect(state.player_location_id).to eq("quiet_meadow")
        expect(state.locations).to match_array(expected_locations)
        expect(state.items).to match_array(expected_items)
        expect(state.characters).to eq(expected_characters)
      end
    end

    context "when the file does not exist" do
      let(:filename) { "does_not_exist" }

      it "returns false" do
        expect(result).to eq(false)
      end

      it "does not modify the state" do
        result
        expect(state.player_location_id).to be_nil
        expect(state.locations).to be_empty
        expect(state.items).to be_empty
        expect(state.characters).to be_empty
      end
    end
  end

  describe ".save" do
    let(:result) { described_class.save(state, filename) }
    let(:filename) { "saved_game_test_temp" }
    let(:state) { ::State.new(adventure: "test") }
    let(:load_file_path) { "./spec/fixtures/files/saved_game_test_1.yml" }
    let(:temp_file_path) { described_class.path_from_filename(filename, state) }

    let(:expected_contents) do
      <<~CONTENTS
        ---
        adventure: test
        player:
          location_id: quiet_meadow
          health: 10
          turn_count: 0
          quitting: false
        messages: {}
        items:
        - id: sword
          name: engraved sword
          description: a jewel-encrusted sword
          described: false
          text: Sunshine makes me happy :)
          location_key: items.chest
          size: 30
          capacity: 0
          lockable: false
          locked: false
          openable: false
          opened: false
          edible: false
          can_unlock: []
        - id: key
          name: iron key
          description: a solid iron key
          described: false
          text:
          location_key: twisted_trees
          size: 3
          capacity: 0
          lockable: false
          locked: false
          openable: false
          opened: false
          edible: false
          can_unlock:
          - chest
        - id: chest
          name: chest
          description: a large oaken chest with a heavy lock
          described: false
          text:
          location_key: tropical_forest
          size: 999
          capacity: 100
          lockable: true
          locked: true
          openable: true
          opened: false
          edible: false
          can_unlock: []
        locations:
        - id: quiet_meadow
          name: quiet meadow
          description:
            general: You find yourself in a quiet meadow.
          movements:
            east:
              location_id: sunlit_hill
            west:
              location_id: twisted_trees
          described: false
        - id: sunlit_hill
          name: sunlit hill
          description:
            general: A sunlit hill.
          movements:
            west:
              location_id: quiet_meadow
          described: true
        characters:
        - id: squirrel
          name: bright-eyed squirrel
          description: You see a squirrel.
          described: false
          location_key: top_of_oak_tree
          reactions:
            talk: The squirrel chatters back at you.
          trades:
          - accepts: sandwich
            gives: key
            description: Done deal.
      CONTENTS
    end

    before { described_class.restore_using_file_path!(state, load_file_path) }
    after { File.delete(temp_file_path) if File.exist?(temp_file_path) }

    context "when the file does not exist" do
      it "returns true" do
        expect(result).to eq(true)
      end

      it "saves the file in yaml format with expected contents" do
        result
        contents = File.read(temp_file_path)
        expect(contents).to eq(expected_contents)
      end
    end
  end
end
